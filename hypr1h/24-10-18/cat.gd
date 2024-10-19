class_name Cat
extends Area2D

const GRAV: float = 1200

var floor_y: float = randf_range(616, 646)
var jump_timer: float = 0
var vel = 0
var jumping := false
var picked_up := false
var lifetime := 0.0
var touched := false

func _ready() -> void:
    global_position = Vector2(1500, floor_y)

func pick_up():
    picked_up = true
    $AnimatedSprite2D.play("jump")
    scale.x *= -1
    position = Vector2(-160, 87)
    $CollisionShape2D.set_deferred("disabled", true)

func _process(delta: float) -> void:
    if picked_up:
        lifetime += delta
        rotation_degrees = sin(lifetime * 3.0) * 6.0
    else:
        position.x -= get_parent().speed * delta
        if position.x < -500:
            queue_free()
        if jumping:
            position.y += vel * delta
            vel += GRAV * delta
            if global_position.y >= floor_y:
                global_position.y = floor_y
                $AnimatedSprite2D.play("default")
                jumping = false
        else:
            jump_timer -= delta
            if jump_timer <= 0:
                jump_timer = 0.4
                vel = -400
                jumping = true
                $AnimatedSprite2D.play("jump")
