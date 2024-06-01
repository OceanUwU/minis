extends Node

@export var animal_scene: PackedScene
@export var bg_scene: PackedScene
@onready var camera: Camera2D = $Camera2D

func _ready():
    var possible_animations = ["dog", "snail", "rat"]
    for i in 600:
        var animal: Area2D = animal_scene.instantiate()
        while true:
            animal.position = Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000))
            if animal.get_overlapping_areas().size() == 0:
                break
        animal.get_node("AnimatedSprite2D").animation = possible_animations[randi_range(0, 2)]
        add_child(animal)
    var possible_bgs = ["grass", "grass", "grass", "grass2", "grass2", "grass2", "grass", "grass2", "sign", "bush"]
    for i in 600:
        var bg: AnimatedSprite2D = bg_scene.instantiate()
        bg.position = Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000))
        bg.animation = possible_bgs[randi_range(0, 9)]
        add_child(bg)

var righting = false
var last_pos: Vector2
func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
        righting = event.is_pressed()
        last_pos = event.global_position
    if event is InputEventMouseMotion and righting:
        camera.position -= event.global_position - last_pos
        last_pos = event.global_position
