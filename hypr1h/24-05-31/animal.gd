extends Area2D

var mousing: bool = false;
var velocity: Vector2 = Vector2(randf_range(-65, -20), randf_range(-20, 20))

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite2D.play()

func _physics_process(delta):
    position += velocity * scale * delta
    if (abs(position.x) > 2000):
        velocity.x *= -1
        position += velocity * scale * delta
    if (abs(position.y) > 2000):
        velocity.y *= -1
        position += velocity * scale * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
    if mousing && event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
        if (name == "Duck"):
            get_tree().change_scene_to_file("res://win.tscn")
        else:
            get_tree().change_scene_to_file("res://lose.tscn")

func _on_mouse_exited():
    mousing = false

func _on_mouse_entered():
    mousing = true

func _on_area_entered(_area:Area2D):
    scale.x *= -1
    velocity.y *= -1
