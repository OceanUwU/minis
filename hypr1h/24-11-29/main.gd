extends Node

@export var ball_scene: PackedScene
@export var ball_interval: float

var ball_timer: float = 0.0
var score: int
var playing: bool

func _ready() -> void:
    start()
    ball_timer = 5.0

func start() -> void:
    ball_timer = 0
    score = 0
    $Score.text = "0"
    playing = true
    $GameOver.hide()
    for i in get_children():
        if i is Ball:
            i.queue_free()

func _on_button_pressed() -> void:
    start()

func _process(delta: float) -> void:
    ball_timer -= delta
    if playing and ball_timer < 0:
        ball_timer += ball_interval
        var ball: Ball = ball_scene.instantiate()
        ball.position = Vector2(randf_range(750, 1020), -42)
        add_child(ball)
        ball.connect("score", score_one)
        ball.connect("die", die)

func score_one():
    if playing:
        score += 1
        $Score.text = str(score)

func die():
    playing = false
    $GameOver.show()
