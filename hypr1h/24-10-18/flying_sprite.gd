extends Sprite2D

const GRAV: float = 800
var vel = Vector2(randf_range(-300, 300), randf_range(-600, 50))
var rot_vel = randf_range(-200, 200)

func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    position += vel * delta
    vel.y += GRAV * delta
    rotation_degrees += rot_vel * delta
    if position.y > 2000:
        queue_free()
