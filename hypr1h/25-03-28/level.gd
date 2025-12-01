extends Node

@export var num_others: int
@export var other: PackedScene
@export var next_level: PackedScene
var lost: bool = false

func _ready() -> void:
	$Deadthscreen.hide()
	for i in num_others:
		var animal: CharacterBody2D = other.instantiate()
		animal.position = Vector2(randf_range(46, 1233), randf_range(19, 698))
		add_child(animal)

func _on_duck_die() -> void:
	if lost:
		return
	lost = true
	for i in get_children():
		if i is Animal:
			(i as Animal).create_tween().tween_property(i, "modulate:a", 0, randf_range(0.2, 0.5))
	await get_tree().create_timer(1.2).timeout
	$Deadthscreen.show()
	$Deadthscreen.modulate.a = 0
	create_tween().tween_property($Deadthscreen, "modulate:a", 1.0, 0.4)

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_duck_win() -> void:
	if lost:
		return
	lost = true
	for i in get_children():
		if i is Animal:
			(i as Animal).create_tween().tween_property(i, "modulate:a", 0, randf_range(0.2, 0.5))
	await get_tree().create_timer(1.2).timeout
	get_tree().change_scene_to_packed(next_level)
