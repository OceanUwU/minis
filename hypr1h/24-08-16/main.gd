extends Node

var lifetime := 0.0
var ended := false

func _process(delta: float) -> void:
    lifetime += delta
    if !ended:
        $Label.text = "Depth: " + str(round(lifetime * 8)) + "m"

func end():
    ended = true
    $NumberCol.increase_speed = false
    $End.show()
    $End.modulate.a = 0
    get_tree().create_tween().tween_property($End, "modulate:a", 1.0, 0.5)

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey && event.keycode == KEY_R:
        get_tree().reload_current_scene()
