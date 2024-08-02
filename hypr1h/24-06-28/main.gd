extends Node

@export var sky: Control
@export var grass: Control
@export var lava: Control
@export var worm: Node2D
@export var win: Control
@export var loss: Control
@export var timer: Label

var done = false
var time = 0.0

func _process(delta):
    sky.position.x = worm.position.x - 500
    grass.position.x = worm.position.x - 500
    lava.position.x = worm.position.x - 500
    if !done:
        timer.text = "%.2fs" % time
        time += delta
        if worm.global_position.y < grass.global_position.y:
            finish()
            win.show()
        if worm.global_position.y > lava.global_position.y:
            finish()
            loss.show()
        lava.position.y -= 250 * delta

func finish():
    done = true
    worm.process_mode = Node.PROCESS_MODE_DISABLED

func _input(event):
    if event is InputEventKey && event.keycode == KEY_R && event.is_pressed():
        get_tree().reload_current_scene()
