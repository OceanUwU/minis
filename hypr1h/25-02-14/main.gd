class_name Main extends Node

static var inst: Main
var desired_sequence: Array[int] = [0, 0, 0, 0]
var timer: float = 0
@export var round_time: float = 10.0
@export var left_boundary: Node2D
@export var right_boundary: Node2D
@export var duck_scene: PackedScene
@export var ducks: Node
@export var duck_example: Sprite2D
var score: int = 0
var best: int = -1
var playing: bool = false

func _ready() -> void:
    inst = self
    $Start.show()
    $GameOver.hide()
    
func _process(delta: float) -> void:
    if playing:
        timer -= delta
        $Control/Timer.text = "%.1fs" % timer
        if timer < 0:
            lose()

func _input(event: InputEvent) -> void:
    if playing and event is InputEventMouseButton and event.button_index == 1 and event.pressed:
        var closest_distance: float = 1000000000000
        var closest: Duck
        var mouse_pos := duck_example.get_global_mouse_position()
        for duck: Duck in ducks.get_children():
            var dist := duck.global_position.distance_squared_to(mouse_pos)
            if dist < closest_distance:
                closest_distance = dist
                closest = duck
        print(closest_distance)
        if closest != null and closest_distance < 10000:
            pick(closest)

func start() -> void:
    score = 0
    $Control/Score.text = str(score)
    $Start.hide()
    $GameOver.hide()
    start_round()

func pick(duck: Duck) -> void:
    if duck.correct:
        score_point()
    else:
        lose()
    for d: Duck in ducks.get_children():
        if not d.correct:
            d.fade_away()

func score_point() -> void:
    score += 1
    $Control/Score.text = str(score)
    playing = false
    await get_tree().create_timer(2.0).timeout
    start_round()

func start_round() -> void:
    duck_example.show()
    timer = round_time
    for duck in ducks.get_children():
        duck.queue_free()
    desired_sequence = [0, 0, 0, 0]
    for i in len(desired_sequence):
        desired_sequence[i] = randi_range(0, 1)
        duck_example.get_child(i).visible = desired_sequence[i] == 1
    var num_ducks: int = 10 + 4 * score
    for i in num_ducks:
        var duck: Duck = duck_scene.instantiate()
        duck.global_position = Vector2(randf_range(left_boundary.global_position.x - duck.top_left.position.x + 10, right_boundary.global_position.x - duck.bottom_left.position.x - 10),
            randf_range(left_boundary.global_position.y - duck.top_left.position.y + 10, right_boundary.global_position.y - duck.bottom_left.position.y - 10))
        ducks.add_child(duck)
        if i == 0:
            duck.set_pattern(desired_sequence)
            duck.correct = true
    playing = true

func lose() -> void:
    timer = 0
    $Control/Timer.text = "%.1fs" % timer
    playing = false
    if score > best:
        best = score
        $Control/Best.text = "Best: " + str(best)
    $GameOver.show()

func _on_button_pressed() -> void:
    for duck in ducks.get_children():
        duck.queue_free()
    start()
