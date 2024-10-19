extends Area2D

const MAX_SPEED: float = 400
const MOVE_MULT: float = 3.0
const MAX_ROTATION: float = 30.0
var has_cat := false
@export var flying_sprite_scene: PackedScene
var alive := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

func _process(delta: float) -> void:
    var dir: float = clamp((get_global_mouse_position().y - global_position.y) * MOVE_MULT, -MAX_SPEED, MAX_SPEED)
    rotation_degrees = dir / MAX_SPEED * MAX_ROTATION
    position.y += dir * delta
    position.y = min(position.y, 631)


func _on_area_entered(area: Area2D) -> void:
    if area is Cat && alive:
        if area.touched:
            return
        area.touched = true
        if has_cat:
            area.queue_free()
        else:
            has_cat = true
            area.reparent(self)
            area.pick_up()
        get_parent().score()
    elif area is Pumpkin && alive:
        alive = false
        get_parent().game_over()
        for i in [$Sprite2D, $Cat, $Sprite2D/Sprite2D]:
            var spr := flying_sprite_scene.instantiate()
            spr.texture = i.texture
            spr.global_transform = i.global_transform
            i.hide()
            get_parent().add_child(spr)
        queue_free()
