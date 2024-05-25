extends Node2D
signal won

var color: Color = Color(randf(), randf(), randf(), 1.0)
var correct: bool = false
var type: int = randi_range(0, 1)
var moused: bool = false

func _ready() -> void:
    position = Vector2(randf_range(20, get_viewport_rect().size.x - 20), randf_range(20, get_viewport_rect().size.y - 20))
    rotation = randf_range(0, TAU)
    queue_redraw()

func _draw() -> void:
    match type:
        0:
            draw_colored_polygon([Vector2(-10, -10), Vector2(0, 10), Vector2(10, -10)], color)
            draw_line(Vector2(-10, -10), Vector2(0, 10), Color.BLACK, 2)
            draw_line(Vector2(10, -10), Vector2(0, 10), Color.BLACK, 2)
            draw_line(Vector2(-10, -10), Vector2(10, -10), Color.BLACK, 2)
        1:
            draw_colored_polygon([Vector2(-10, -10), Vector2(10, -10), Vector2(10, 10), Vector2(-10, 10)], color)
            draw_line(Vector2(-10, -10), Vector2(10, -10), Color.BLACK, 2)
            draw_line(Vector2(10, -10), Vector2(10, 10), Color.BLACK, 2)
            draw_line(Vector2(10, 10), Vector2(-10, 10), Color.BLACK, 2)
            draw_line(Vector2(-10, 10), Vector2(-10, -10), Color.BLACK, 2)


func _on_mouse_exited():
    moused = false

func _on_mouse_entered():
    moused = true

func _input(event):
    if moused and event is InputEventMouseButton and event.pressed:
        if correct:
            won.emit()
        else:
            hide()
            moused = false
            position.y += 10000

func _on_touch_screen_button_pressed():
    if correct:
        won.emit()
    else:
        hide()
        moused = false
        position.y += 10000
