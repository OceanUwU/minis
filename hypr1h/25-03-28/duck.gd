extends CharacterBody2D

@export var sprite: AnimatedSprite2D

signal die
signal win

const GRAVITY: float = 1200.0
const JUMP_POWER: float = 700
var MOVE_SPEED: float = 200

var yVel: float = 0

func _ready() -> void:
	sprite.play("default")

func _physics_process(delta: float) -> void:
	var dir: int = 0
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if dir != 0:
		sprite.flip_h = dir == 1
	if is_on_wall() and get_wall_normal().x == -dir:
		dir = 0
	velocity = Vector2(MOVE_SPEED * dir, yVel)
	move_and_slide()
	if is_on_floor():
		yVel = 0
	else:
		yVel += GRAVITY * delta
	if is_on_ceiling() && yVel < 0:
		yVel = 0
	var coll := get_last_slide_collision()
	if coll != null and coll.get_collider() is Spikes:
		process_mode = Node.PROCESS_MODE_DISABLED
		die.emit()
	if coll != null and coll.get_collider() is Goal:
		process_mode = Node.PROCESS_MODE_DISABLED
		win.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key_event: InputEventKey = event
		if key_event.key_label == KEY_SPACE and is_on_floor():
			yVel = -JUMP_POWER
