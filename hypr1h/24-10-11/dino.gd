extends AnimatedSprite2D

@export var osc_amount: float
@export var osc_speed: float
@export var bounce_amount: float
@export var bounce_speed: float
var orig_pos: Vector2
var lifetime: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    orig_pos = position
    play()

func _process(delta: float) -> void:
    lifetime += delta
    position.x = orig_pos.x + sin(lifetime * osc_speed) * osc_amount
    position.y = orig_pos.y + abs(sin(lifetime * bounce_speed)) * -bounce_amount
    $ColorRect.color.a = ((sin(lifetime) +1) / 2) * 0.3 + 0.2
    pass
