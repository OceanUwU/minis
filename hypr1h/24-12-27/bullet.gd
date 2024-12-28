class_name Bullet extends Area2D

@export var speed: float
var angle: float

func _process(delta: float) -> void:
    position += Vector2.from_angle(angle) * delta * speed
    if not get_viewport_rect().has_point(global_position):
        queue_free()
