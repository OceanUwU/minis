extends AnimatedSprite2D

var alive := true

func _ready() -> void:
    play("default")
    global_position = $"../Catap".global_position + Vector2.from_angle(randi_range(-25.0, 20.0) * TAU / 360) * 1150

func _process(delta: float) -> void:
    if alive:
        if global_position.distance_to($"../Catap".global_position) < 200 && get_parent().heart_there:
            alive = false
            var tween = get_tree().create_tween()
            tween.set_parallel(false)
            tween.set_ease(Tween.EASE_IN_OUT)
            tween.set_trans(Tween.TRANS_QUAD)
            tween.tween_property(self, "self_modulate:a", 0, 0.5)
            tween.tween_callback(queue_free)
        if global_position.distance_to($"../Catap".global_position) < 5:
            alive = false
            get_parent().lose()
        position += global_position.direction_to($"../Catap".global_position) * 50 * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
    if area.get_parent() is Heart:
        alive = false
        $Area2D.queue_free()
        var tween = get_tree().create_tween()
        tween.set_parallel()
        tween.set_ease(Tween.EASE_IN_OUT)
        tween.set_trans(Tween.TRANS_QUAD)
        tween.tween_property(self, "self_modulate:a", 0, 0.5)
        tween.tween_property($Heart, "modulate:a", 1, 0.5)
        tween.set_parallel(false)
        tween.tween_property(self, "global_position", $"../Reserve".global_position, 0.5)
        tween.tween_callback(get_parent().gain_heart)
        tween.tween_callback(queue_free)
