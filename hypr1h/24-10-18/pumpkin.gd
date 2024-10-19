class_name Pumpkin
extends Area2D

const GRAV: float = 1200
var floor_y: float = randf_range(616, 646)
var vel = 0

func _ready() -> void:
    global_position = Vector2(1500, floor_y)

func _process(delta: float) -> void:
    position.x -= get_parent().speed * delta
    if position.x < -500:
        queue_free()
    vel += GRAV * delta
    position.y += vel * delta
    if global_position.y >= floor_y:
        vel = randf_range(-600, -1200)
        
