class_name Ghost
extends AnimatedSprite2D

var speed: float = randf_range(0.5, 1.2) * 120.0
@onready var target: Vector2 = get_viewport_rect().size / 2.0
var alive: bool = true

func _ready() -> void:
    play(str(randi_range(0, 3)))
    position = target + target.rotated(randf() * TAU) * 1.5

func _physics_process(delta: float) -> void:
    if alive:
        position += position.direction_to(target) * speed * delta
        if position.distance_to(target) < 5:
            alive = false
            get_parent().lose()

func _on_area_2d_area_entered(area: Area2D) -> void:
    if area.get_parent() is Light:
        alive = false
        get_parent().add_score()
        $Area2D.queue_free()
        fade_away()
        
func fade_away():
    alive = false
    var tween := get_tree().create_tween()
    tween.tween_property(self, "modulate:a", 0.0, 0.5)
    tween.tween_callback(queue_free)
