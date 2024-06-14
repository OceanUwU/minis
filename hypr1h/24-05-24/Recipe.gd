extends Sprite2D

@export var images: Array[Texture2D]

var needed = [
    ["Egg", 3],
    ["Milk", 2],
    ["Flour", 2],
    ["Sugar", 1]
]
var collected = [0, 0, 0, 0]

func eat(food) -> void:
    for i in 4:
        if collected[i] < needed[i][1]:
            if food.contains(needed[i][0]):
                collected[i] += 1
                if collected[i] >= needed[i][1]:
                    texture = images[i]
                    if i == 3:
                        get_parent().get_parent().get_node("AnimationPlayer").play("new_animation")
                break
            else:
                get_tree().reload_current_scene()
                break
