extends StaticBody2D

@export var colour: Color

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	var rect_shape: RectangleShape2D = $CollisionShape2D.shape
	draw_rect(Rect2($CollisionShape2D.position - rect_shape.size / 2, rect_shape.size), colour)
