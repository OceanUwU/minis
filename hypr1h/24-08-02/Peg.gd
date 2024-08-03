extends Node2D

@export var background_colour: Color
@export var available_colour: Color
var main: Node
var available: bool = false
var x: int
var y: int

func _ready():
    main = get_parent()

func _process(_delta):
    queue_redraw()

func _draw():
    draw_circle(Vector2.ZERO, 20.0, background_colour)
    if available:
        draw_arc(Vector2.ZERO, 12.0, 0, TAU, 30, available_colour, 2.0)

func filled() -> bool:
    return get_child_count() > 0
