extends RigidBody2D

var gravity: Vector2 = Vector2.ZERO
@export var gravity_scale_food: float = 1.0


func _ready() -> void:
    add_to_group("food")

func _physics_process(_delta: float) -> void:
    apply_central_force(gravity * gravity_scale_food * 0.2)
    move_and_collide(linear_velocity)
