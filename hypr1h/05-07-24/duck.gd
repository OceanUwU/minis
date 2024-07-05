extends CharacterBody2D

@export var projectile: PackedScene
var vel: Vector2 = Vector2(randf_range(-110, 110), randf_range(-110, 110))
var timer: float = 0

func _ready():
    $AnimatedSprite2D.play()
    if vel.x > 0:
        $AnimatedSprite2D.scale.x *= -1
    shoot(false)
    process_mode = Node.PROCESS_MODE_ALWAYS

func shoot(actually: bool) -> void:
    if actually:
        var offset = randf_range(0, PI)
        for i in 7:
            var p: Node2D = projectile.instantiate()
            p.rotation = TAU * i / 7 + offset
            p.global_position = global_position
            get_tree().current_scene.add_child(p)
    timer += randf_range(3.5, 6.5)

func _physics_process(delta):
    if abs(position.x) > 500:
        vel.x *= -1
        $AnimatedSprite2D.scale.x *= -1
    if abs(position.y) > 500:
        vel.y *= -1
    velocity = vel
    move_and_slide()
    timer -= delta
    if timer < 0:
        shoot(true)
