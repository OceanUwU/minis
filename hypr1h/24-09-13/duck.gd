@tool
extends AnimatedSprite2D

@export var circle_colour: Color

func _process(delta: float) -> void:
    play("default")
    queue_redraw()

func _draw() -> void:
    draw_circle(Vector2.ZERO, Light.MIN_DISTANCE, circle_colour, false, 4)
