extends CharacterBody2D

const SPEED: float = 200.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
    sprite.play()

func _process(delta):
    $Camera2D.position = $Camera2D.position.lerp(Vector2.ZERO, 1.0 - pow(0.001, delta))

func _physics_process(delta):
    var dir: Vector2 = Vector2(0, 0)
    if Input.is_action_pressed("ui_up"): dir += Vector2.UP
    if Input.is_action_pressed("ui_right"): dir += Vector2.RIGHT
    if Input.is_action_pressed("ui_down"): dir += Vector2.DOWN
    if Input.is_action_pressed("ui_left"): dir += Vector2.LEFT
    dir = dir.normalized()
    sprite.animation = "walking" if dir.length() > 0 else "idle"
    velocity = dir * SPEED
    position += velocity * delta
    $Camera2D.position -= velocity * delta
    #move_and_slide()
    position = Vector2(clamp(position.x, -500, 500), clamp(position.y, -500, 500))