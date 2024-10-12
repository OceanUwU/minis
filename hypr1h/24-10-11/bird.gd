extends Area2D

var speed: float = randf_range(135.0, 275.0)
var moused: bool = false
var held: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $AnimatedSprite2D.play()
    add_to_group("birds")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if !held:
        position.x -= speed * delta
    if position.x < -1000:
        queue_free()

func _on_mouse_entered() -> void:
    moused = true


func _on_mouse_exited() -> void:
    moused = false


func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
        held = moused && event.is_pressed()
    elif event is InputEventMouseMotion:
        if held:
            position += event.relative
        
