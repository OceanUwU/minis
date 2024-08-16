extends Area2D

const X_SPEED := 60.0
const DRILL_RATE = 60.0

@onready var col = $"../NumberCol"

func _ready() -> void:
    $AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
    if global_position.x >= col.global_position.x && !col.broken:
        position.x -= col.speed * delta
        var num_num = floor((global_position.y - col.global_position.y) / 45)
        col.numbers[num_num] -= DRILL_RATE * delta
        if col.numbers[num_num] > 0:
            return
        else:
            col.broken = true
    var dir := Input.get_vector("none", "none", "ui_up", "ui_down")
    position += dir * 5
    position.x += X_SPEED * delta
    position.x = min(position.x, 1260)
    position.y = clamp(position.y, 50, 680)
    if position.x < 0:
        get_parent().end()
        queue_free()
