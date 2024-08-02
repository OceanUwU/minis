extends Node2D

@export var bg_scene: PackedScene
@export var timer: Label
@export var game_over: Control
@export var fader: Control

var time: float = 0.0

func _ready():
    var possible_bgs = ["grass", "grass", "grass", "grass2", "grass2", "grass2", "grass", "grass2", "sign", "bush"]
    game_over.hide()
    for i in 600:
        var bg: AnimatedSprite2D = bg_scene.instantiate()
        bg.position = Vector2(randf_range(-2000, 2000), randf_range(-2000, 2000))
        bg.animation = possible_bgs[randi_range(0, 9)]
        add_child(bg)
    fader.show()
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_QUAD)
    tween.tween_property(fader, "modulate:a", 0.0, 1.5)

func _process(delta):
    time += delta
    timer.text = "survived for " + "%.1fs" % time

var ended = false
func end():
    if ended: return
    ended = true
    set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
    game_over.show()
    game_over.modulate.a = 0
    $Player/AnimationPlayer.play("explode")
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_QUAD)
    tween.set_parallel()
    tween.tween_property(timer, "position", Vector2(-204, -216), 2.0)
    tween.tween_property(game_over, "modulate:a", 1.0, 2.0)

var restarting = false
func _on_button_pressed():
    if restarting: return
    restarting = true
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_QUAD)
    tween.tween_property(fader, "modulate:a", 1.0, 1.5)
    await tween.finished
    get_tree().reload_current_scene()
