class_name Item
extends Sprite2D

@export var types: Array[Texture2D]
var mousing: bool = false
var grabbed: bool = false
var on_conveyor: bool = true
var grabbed_before: bool = false
var char_inside: Character
var fall_acc: float = 500.2
var fall_vel: float = 0

func _ready() -> void:
    texture = types[randi() % types.size()]

func _process(delta: float) -> void:
    if grabbed:
        global_position = get_global_mouse_position()
    elif grabbed_before:
        fall_vel += fall_acc * delta
        position.y += fall_vel * delta
    if position.y > 10000:
        queue_free()

func _on_area_2d_mouse_entered() -> void:
    mousing = true

func _on_area_2d_mouse_exited() -> void:
    mousing = false

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
        if grabbed && !event.pressed:
            grabbed = false
            if char_inside != null:
                char_inside.pickup(texture)
                queue_free()
        elif event.pressed && mousing && !grabbed_before:
            grabbed = true
            on_conveyor = false
            grabbed_before = true

func _on_area_2d_area_entered(area: Area2D) -> void:
    if area is Character && area.arrived && !area.returning:
        char_inside = area

func _on_area_2d_area_exited(area: Area2D) -> void:
    if area == char_inside:
        char_inside = null
