extends Area2D

var value: int
var target_pos: Vector2

func _ready():
    $Back/Face.animation = str(value)

func _process(delta):
    global_position = global_position.lerp(target_pos, 1 - pow(0.01, delta))
    scale = scale.lerp(Vector2.ONE, 1 - pow(0.01, delta))

func del():
    var tween := get_tree().create_tween()
    tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
    await tween.finished
    queue_free()

func flip():
    var tween := get_tree().create_tween()
    tween.tween_property(self, "scale:x", 0, 0.15)
    await tween.finished
    $Back/Cardback.queue_free()
    tween = get_tree().create_tween()
    tween.tween_property(self, "scale:x", 1.0, 0.15)
    await tween.finished

