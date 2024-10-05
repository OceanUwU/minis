extends Node

@export var char_scene: PackedScene
var score := 0
var spawn_timer: float = 0.0
@export var spawn_delay: float
var characters := []
var num_characters = 6
var char_gap := 100
var playing = true

func _ready() -> void:
    for i in num_characters:
        characters.append(null)

func _process(delta: float) -> void:
    spawn_timer -= delta
    if spawn_timer < 0:
        spawn_timer += spawn_delay
        var slots := []
        for i in num_characters:
            if characters[i] == null:
                slots.append(i)
        if slots.size() > 0:
            var char := char_scene.instantiate()
            var slot = slots[randi() % slots.size()]
            add_child(char)
            characters[slot] = char
            char.position = Vector2(0, 450 + (slot - (num_characters / 2)) * char_gap)
            print(char.position)

func satisfy(char: Character):
    if playing:
        score += 1
    $Score.text = str(score)
    var i = 0
    while i < characters.size():
        if characters[i] == char:
            characters[i] = null
        i += 1

func game_over():
    playing = false
    $Over.show()

func _on_button_pressed() -> void:
    get_tree().reload_current_scene()
