class_name Bird extends Node

@export var bird_scene: PackedScene
var playing := true
var spawned: int = 0
var spawn_timer: float = 0
var time_score: float = 0.0
@export var eat_spot: Node2D

func _ready():
    start()

func start():
    playing = true
    spawned = 9
    spawn_timer = 0.0
    time_score = 0.0
    $GameOver.hide()
    for i in get_tree().get_nodes_in_group("birds"):
        i.queue_free()

func _process(delta: float):
    spawn_timer -= delta
    if spawn_timer <= 0:
        var bird := bird_scene.instantiate()
        add_child(bird)
        bird.global_position.x = $Dino/ColorRect.global_position.x + $Dino/ColorRect.size.x
        bird.global_position.y = $Dino/ColorRect.global_position.y + $Dino/ColorRect.size.y / 2 + randf_range(-50, 50)
        if playing:
            spawned += 1
        spawn_timer = (1.0 / log(spawned + 20)) / log(spawned + 2) * 9
    if playing:
        time_score += delta
        $Timer.text = "%.1fs" % time_score
    for i in get_tree().get_nodes_in_group("birds"):
        if is_instance_valid(i) && eat_spot.global_position.distance_squared_to(i.global_position) < 4900:
            end()
            i.queue_free()

func end():
    if playing:
        playing = false
        $GameOver.show()

func _on_retry_pressed() -> void:
    start()
