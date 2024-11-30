extends Node2D

@export var player: bool
@export var move_speed: float
@export var turn_speed: float
@export var turn_amount: float
@export var release_speed: float
@export var release_buffer: float

var driving: bool = false
var releasing: bool = false
var power: float
var time_since_release_stopped: float = 0.0

func _ready() -> void:
    if not player:
        scale.x *= -1

func _process(delta: float) -> void:
    if player:
        if releasing:
            rotation = min(rotation + release_speed * delta, 0)
            if rotation >= -0.001:
                releasing = false
                rotation = 0
                time_since_release_stopped = 0
        elif driving or Input.is_action_pressed("drive"):
            driving = true
            rotation = max(rotation - turn_speed * delta, -turn_amount)
            if not Input.is_action_pressed("drive"):
                power = -rotation / turn_amount
                driving = false
                releasing = true
                time_since_release_stopped = 0
        if not driving and not releasing:
            var target := get_global_mouse_position()
            if global_position.distance_to(target) > 2.0:
                global_position = global_position.move_toward(target, move_speed * delta)
                global_position.x = clamp(global_position.x, 900, 1280)
                global_position.y = clamp(global_position.y, 300, 700)
        time_since_release_stopped += delta

func _on_area_2d_area_entered(area: Area2D) -> void:
    if area is Ball:
        if releasing or time_since_release_stopped <= release_buffer:
            area.hit(power)
        else:
            area.hit(0)
