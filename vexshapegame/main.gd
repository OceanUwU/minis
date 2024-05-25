extends Node

@export var shape_scene: PackedScene
var level: int = 3
var shapes: Array = []

func _ready() -> void:
    var save_game = FileAccess.open("user://shapes.save", FileAccess.READ)
    if (save_game != null):
        level = int(save_game.get_line())
    level -= 1
    new_level()

func new_level() -> void:
    for i in shapes:
        i.queue_free()
    level += 1
    var save_game = FileAccess.open("user://shapes.save", FileAccess.WRITE)
    save_game.store_line(str(level))
    $Label.text = str(level)
    shapes = []
    for i in range(level):
        var shape = shape_scene.instantiate()
        shapes.push_back(shape)
        add_child(shape)
        shape.connect("won", new_level)
    shapes[randi() % level].correct = true;
