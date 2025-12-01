class_name Animal extends CharacterBody2D

@export var sprite: AnimatedSprite2D

const GRAVITY: float = 500.0

var move_speed: float = randf_range(40, 220)
var jump_power: float = randf_range(300, 600)
var dir: int = randi_range(0, 1) * 2 - 1
var yVel: float = 0
var time_on_floor: float = 0.0
var time_till_jump: float = randf_range(1, 2)

func _ready() -> void:
	sprite.play(["dog", "rat", "snail"].pick_random())
	sprite.speed_scale = randf_range(0.8, 1.2)
	sprite.flip_h = dir == 1

func _physics_process(delta: float) -> void:
	velocity = Vector2(move_speed * dir, yVel)
	move_and_slide()
	if is_on_wall():
		dir *= -1
		sprite.flip_h = dir == 1
	if is_on_floor():
		yVel = 0
		time_till_jump -= delta
		if time_till_jump < 0:
			yVel = -jump_power
			time_till_jump = randf_range(1, 4)
	else:
		yVel += GRAVITY * delta
	if is_on_ceiling() && yVel < 0:
		yVel = 0
