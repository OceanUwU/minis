extends Node

@export var bg_scene: PackedScene
@export var duck_scene: PackedScene
@export var game_over: Control

var duck_timer: float = 0
var ducks_spawned: int = 0
var ducks_left: int = 999999
var playing: bool = true
@export var counter: Label

func _ready():
    var possible_bgs = ["grass", "grass", "grass", "grass2", "grass2", "grass2", "grass", "grass2", "sign", "bush"]
    for i in 600:
        var bg: AnimatedSprite2D = bg_scene.instantiate()
        bg.position = Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000))
        bg.animation = possible_bgs[randi_range(0, 9)]
        add_child(bg)
    game_over.hide()

func _process(delta: float) -> void:
    duck_timer -= delta
    while duck_timer <= 0 and playing:
        ducks_spawned += 1
        duck_timer += max(0.005, 1 / (1.2 * log(ducks_spawned + 2.7) / log(2.7)))
        add_child(duck_scene.instantiate())

func score() -> void:
    if playing:
        ducks_left -= 1
        counter.text = str(ducks_left)

func lose() -> void:
    if playing:
        playing = false
        game_over.show()

func start() -> void:
    get_tree().reload_current_scene()
