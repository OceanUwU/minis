class_name NumberCol
extends Node2D


var numbers = []
var broken := false
var speed = 280
var times = 0
var increase_speed := true

func _ready() -> void:
    for i in 14:
        numbers.append(randi_range(10, 99))

func _process(delta: float) -> void:
    position.x -= speed * delta
    if (position.x <= -60):
        position.x = 1300
        times += 1
        if increase_speed:
            speed += 30
        broken = false
        for i in 14:
            numbers[i] = randi_range(10, 99)
    queue_redraw()

func _draw() -> void:
    var y = -45
    for i in numbers:
        y += 45
        if i <= 0: continue
        draw_rect(Rect2(Vector2(0, y), Vector2(45, 45)), Color.FIREBRICK, true)
        draw_rect(Rect2(Vector2(0, y), Vector2(45, 45)), Color.DARK_RED, false, 5)
        draw_string(ThemeDB.fallback_font, Vector2(10.5, y + 32.5), str(round(i)), HORIZONTAL_ALIGNMENT_CENTER, -1, 24)
