class_name Duck extends Area2D

@export var speed: float
@export var boss_speed: float
@export var boss_hits: int
@export var boss_size: float

var died: bool = false
var boss: bool = randi() % 20 == 0
var hits: int = 0
var flash_time: float = 0

func _ready() -> void:
    var angle = randf() * TAU
    if angle < PI / 2 or angle > PI / 2 * 3:
        scale.x *= -1
    if boss: scale *= boss_size
    global_position = get_tree().current_scene.get_node("Player").global_position + Vector2.from_angle(randf() * TAU) * 700
    $AnimatedSprite2D.play()
    if randi() % 999999 == 0:
        $AnimatedSprite2D.play("999999")

func _process(delta: float) -> void:
    flash_time -= delta
    if flash_time > 0:
        print((0.1 - flash_time) / 0.1)
        modulate = Color.BLACK.lerp(Color.WHITE, (1 - flash_time) / 0.1)
    else:
        modulate = Color.WHITE
    var effective_speed = boss_speed if boss else speed
    position += global_position.direction_to(get_tree().current_scene.get_node("Player").global_position) * effective_speed * delta


func _on_area_entered(area: Area2D) -> void:
    if area is Bullet:
        area.queue_free()
        var should_die = true
        hits += 1
        if boss:
            flash_time = 0.1
            should_die = hits >= boss_hits
        if should_die:
            queue_free()
            if not died:
                get_tree().current_scene.score()
            died = true
    elif area.get_parent().name == "Player":
        get_tree().current_scene.lose()
