extends Node2D

const CONTROL: float = 5.5

var gravity: Vector2 = Vector2.ZERO

func _input(event):
    if event.is_action_pressed("ui_right") && event.is_pressed():
        gravity = Vector2.RIGHT * CONTROL
    elif event.is_action_pressed("ui_left") && event.is_pressed():
        gravity = Vector2.LEFT * CONTROL
    elif event.is_action_pressed("ui_up") && event.is_pressed():
        gravity = Vector2.UP * CONTROL
    elif event.is_action_pressed("ui_down") && event.is_pressed():
        gravity = Vector2.DOWN * CONTROL
    else:
        return
    

    for node in get_tree().get_nodes_in_group("food"):
        node.gravity = gravity


#func _process(delta: float) -> void:
#    var change = Vector2(
#        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
#        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#    ) * delta
#    gravity += change
#    for node in get_tree().get_nodes_in_group("food"):
#        node.gravity = gravity