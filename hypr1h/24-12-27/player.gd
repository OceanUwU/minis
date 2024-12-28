extends AnimatedSprite2D

@export var bullet_scene: PackedScene
@export var spread: float
@export var num_bullets: int
@export var bullet_delay: float

@onready var bullet_timer := bullet_delay
var aim_angle = 0

func _ready() -> void:
    play()

func _process(delta: float) -> void:
    bullet_timer -= delta
    aim_angle = global_position.angle_to_point(get_global_mouse_position())
    while bullet_timer <= 0 and get_tree().current_scene.playing:
        bullet_timer += bullet_delay
        for i in num_bullets:
            var bullet := bullet_scene.instantiate()
            bullet.angle = aim_angle + (float(i) / (num_bullets - 1)) * spread - spread / 2
            add_child(bullet)
