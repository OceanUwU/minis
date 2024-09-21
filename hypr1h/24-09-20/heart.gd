class_name Heart
extends Sprite2D

var mousing: bool = false
var grabbed: bool = false
var flung: bool = false
var dir: Vector2

func _ready() -> void:
    global_position = $"../Reserve".global_position
    var tween = get_tree().create_tween()
    tween.set_parallel()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_QUAD)
    tween.tween_property(self, "global_position", $"../Catap/HeartDefaultPos".global_position, 0.5)

func _process(delta: float) -> void:
    modulate.a = 0.8 if (mousing and not grabbed) else 1.0
    if grabbed:
        global_position = $"../Catap/HeartDefaultPos".global_position + $"../Catap/HeartDefaultPos".global_position.direction_to(get_global_mouse_position()) * min(100, $"../Catap/HeartDefaultPos".global_position.distance_to(get_global_mouse_position()))
        $"../Catap/HeartPos".global_position = global_position

func _physics_process(delta: float) -> void:
    if flung:
        position += dir * delta * 14
        dir.y += 120.0 * delta

func _on_area_2d_mouse_entered() -> void:
    if not flung:
        mousing = true

func _on_area_2d_mouse_exited() -> void:
    mousing = false
    
func _input(event: InputEvent):
    if !flung and event is InputEventMouseButton and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
        if event.is_pressed():
            if mousing:
                grabbed = true
        else:
            if grabbed:
                grabbed = false
                mousing = false
                flung = true
                dir = $"../Catap/HeartDefaultPos".global_position - global_position
                $"../Catap/HeartPos".global_position = $"../Catap/HeartDefaultPos".global_position
                get_parent().fling()
