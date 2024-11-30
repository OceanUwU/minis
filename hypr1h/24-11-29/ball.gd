class_name Ball extends Area2D

signal score
signal die

var was_hit: bool = false
var vel: Vector2
var acc: Vector2 = Vector2(0, 180)
var scored: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    vel += acc * delta * 0.5
    position += vel * delta
    vel += acc * delta * 0.5
    if position.y >= 760:
        queue_free()
        if !scored:
            die.emit()
    

func hit(power: float) -> void:
    if was_hit: return
    was_hit = true
    if power <= 0.0:
        vel = Vector2(randf_range(-25, 25), -25)
    else:
        vel = Vector2(-375, -400) * power
        acc.y = 450
            


func _on_area_entered(area: Area2D) -> void:
    if area.name == "Net":
        vel.x = 0
        scored = true
        area.get_node("CPUParticles2D").restart()
        score.emit()
