extends Area2D

const SPEED: float = 150.0

func _ready():
    process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(delta):
    position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
    if abs(position.x) > 2000 or abs(position.y) > 2000:
        queue_free()

func _on_body_entered(body: Node2D):
    if body.name == "Player":
        get_tree().current_scene.end()