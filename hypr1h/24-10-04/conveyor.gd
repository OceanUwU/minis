extends Node2D

@export var item_scene: PackedScene
@export var width: float
@export var outline: Color
@export var bg: Color
@export var speed: float
var pos: float = 0.0
@export var segment_size: float
@export var segments_per_item: int
var top_y: float = 999
var segments_till_item = 0
var items := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

func _process(delta: float) -> void:
    pos += speed * delta
    queue_redraw()
    for i in items:
        if is_instance_valid(i):
            if i.on_conveyor:
                i.position.y += speed * delta

func _draw() -> void:
    draw_rect(Rect2(-width / 2, 0, width, get_viewport_rect().size.y), bg)
    draw_line(Vector2(-width / 2, 0), Vector2(-width / 2, get_viewport_rect().size.y), outline, 5)
    draw_line(Vector2(width / 2, 0), Vector2(width / 2, get_viewport_rect().size.y), outline, 5)
    var y = fmod(pos, segment_size) - segment_size
    var i := 0
    while y < get_viewport_rect().size.y + segment_size:
        if i == 0:
            if y < top_y:
                segments_till_item -= 1
                if segments_till_item <= 0:
                    segments_till_item = segments_per_item
                    var item := item_scene.instantiate()
                    add_child(item)
                    item.position = Vector2(0, y - segment_size / 2)
                    items.append(item)
            top_y = y
        draw_line(Vector2(-width / 2, y), Vector2(width / 2, y), outline, 5)
        y += segment_size
        i += 1
