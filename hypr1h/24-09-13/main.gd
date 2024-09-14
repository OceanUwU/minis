extends Node

@export var ghost_scene: PackedScene
var time_to_next_ghost: float = 0
var ghosts_spawned: int = 0
var score: int = 0
var best: int = 0
var playing: bool = false
var grabbing: bool = false

func _ready():
    pass

func start():
    time_to_next_ghost = 0
    ghosts_spawned = 0
    score = 0
    playing = true
    $Score.show()
    $Best.show()
    $Score.text = "Score: " + str(score)

func lose():
    if playing:
        playing = false
        $GameOver.show()
        if score > best:
            best = score
            $Best.text = "Best: " + str(best)

func add_score():
    if playing:
        score += 1
        $Score.text = "Score: " + str(score)

func _process(delta: float) -> void:
    if playing:
        time_to_next_ghost -= delta
        if time_to_next_ghost < 0:
            make_ghost()
            time_to_next_ghost += (1.0 / log(ghosts_spawned + 20)) / log(ghosts_spawned + 2) * 7

func make_ghost() -> void:
    var ghost = ghost_scene.instantiate()
    add_child(ghost)
    ghosts_spawned += 1


func _on_button_pressed() -> void:
    start()
    $GameOver.hide()
    $Button.hide()
    for node in get_children():
        if node is Ghost:
            node.fade_away()
