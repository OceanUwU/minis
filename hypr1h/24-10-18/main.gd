extends Node

@export var witch_scene: PackedScene
@export var cat_scene: PackedScene
@export var pump_scene: PackedScene
var cat_timer := 500
var score_c: int = 0
var speed := 400.0
var lifetime := 0.0
var dist := 0.0
var playing := true
var cat_counter: int = 0
@export var the_witch: Node

func score():
    if playing:
        score_c += 1
        $Score.text = str(score_c)

func reset():
    if !playing:
        var witch := witch_scene.instantiate()
        add_child(witch)
        witch.position = Vector2(224, -200)
        the_witch = witch
        $GameOver.hide()
        dist = 0
        lifetime = 0
        score_c = 0
        cat_counter = 0
        $Score.text = "0"
        playing = true
        for i in get_children():
            if i is Cat or i is Pumpkin:
                var tween := get_tree().create_tween()
                var lol = i
                tween.tween_property(i, "modulate:a", 0, 0.5)
                tween.tween_callback(func(): if is_instance_valid(lol): lol.queue_free())

func _process(delta: float) -> void:
    speed = 400 + pow(lifetime, 1.4)
    dist += speed * delta
    lifetime += delta
    cat_timer -= speed * delta
    if cat_timer <= 0:
        cat_timer += 400
        if cat_counter % 3 == 0:
            add_child(cat_scene.instantiate())
        else:
            add_child(pump_scene.instantiate())
        cat_counter += 1

func _on_button_pressed() -> void:
    reset()

func game_over():
    if playing:
        playing = false
        $GameOver.show()
