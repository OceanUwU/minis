class_name Light
extends PointLight2D

const MIN_DISTANCE: float = 180
const SPEED: float = 400.0

var lifetime: float = randf_range(0, 100)
@onready var start_scale: float = texture_scale
var oscillate_timescale: float = randf_range(0.5, 2.0)
var mousing: bool = false
var grabbed: bool = false

func _process(delta: float) -> void:
    lifetime += delta
    texture_scale = start_scale + sin(lifetime * oscillate_timescale) * 0.1
    if grabbed:
        global_position += global_position.direction_to(get_global_mouse_position()) * SPEED * delta
        if (get_viewport_rect().size / 2.0).distance_to(global_position) < MIN_DISTANCE:
            global_position = (get_viewport_rect().size / 2.0) + (get_viewport_rect().size / 2.0).direction_to(global_position) * MIN_DISTANCE

func _on_area_2d_mouse_entered() -> void:
    mousing = true

func _on_area_2d_mouse_exited() -> void:
    mousing = false

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
        if grabbed && !event.pressed:
            grabbed = false
            get_parent().grabbing = false
        elif event.pressed && mousing && !get_parent().grabbing:
            grabbed = true
            get_parent().grabbing = true
