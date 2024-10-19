extends Sprite2D

var lifetime := 0.0

func _process(delta: float) -> void:
    lifetime += delta
    rotation_degrees = sin(lifetime * 4.5) * 2.5
