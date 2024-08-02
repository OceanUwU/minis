extends Node2D

const START_SPEED = 150.0
const APPLE_SPEED = 650.0

@export var colour: Color = Color.PINK
@export var ring_colour: Color
@export var background_colour: Color

var speed: float = START_SPEED

var alltime_circle_posses: Array = []
var circle_posses: Array = []

func _draw():
    for pos in alltime_circle_posses:
        draw_circle(-position + pos, 30, background_colour)
    var i = 0
    for pos in circle_posses:
        draw_circle(-position + pos, 25, ring_colour if i > 8 and i % 10 < 2 else colour)
        i += 1

var time_since_last_dot = 0.03

func _physics_process(delta):
    var direction = get_local_mouse_position().normalized()
    position += direction * speed * delta
    speed = lerp(speed, START_SPEED, 1 - 0.4 ** delta)
    time_since_last_dot += delta
    if (time_since_last_dot > 0.03):
        time_since_last_dot -= 0.03
        alltime_circle_posses.push_front(position)
        circle_posses.push_back(position)
        if len(circle_posses) > 50:
            circle_posses = circle_posses.slice(1, 51)

func _process(_delta):
    queue_redraw()

func _on_area_entered(area: Area2D):
    area.queue_free()
    speed = APPLE_SPEED