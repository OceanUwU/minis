extends Node

@export var peg_scene: PackedScene
var pegs = []

func _ready():
    for x in 7:
        var row = []
        for y in 7:
            if (y < 2 or y >= 5) && (x < 2 or x >= 5):
                row.append(null)
            else:
                var peg = peg_scene.instantiate()
                add_child(peg)
                peg.x = x
                peg.y = y
                peg.position = Vector2(x, y) * 50 + Vector2.ONE * 30
                row.append(peg)
        pegs.append(row)
    pegs[3][3].get_child(0).queue_free()


func _on_button_pressed():
    get_tree().reload_current_scene()
