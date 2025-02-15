class_name Duck extends Node2D

var num_accessories: int = 0
var speed: Vector2 = Vector2(randf_range(30, 60) * (randi_range(0, 1) * 2 - 1),
                             randf_range(30, 60) * (randi_range(0, 1) * 2 - 1))
@export var top_left: Node2D
@export var bottom_left: Node2D
var correct: bool = false

func _ready() -> void:
    $AnimatedSprite2D.speed_scale = randf_range(0.8, 1.2)
    scale.x = -sign(speed.x)
    var pattern: Array[int]
    while true:
        var roll: int = randi_range(1, 100)
        if roll <= 1:
            num_accessories = 4
        if roll <= 5:
            num_accessories = 3
        elif roll <= 15:
            num_accessories = 2
        elif roll <= 50:
            num_accessories = 1
        else:
            num_accessories = 0
        pattern = [0, 0, 0, 0]
        for i in num_accessories:
            while true:
                var acc := randi_range(0, 3)
                if pattern[acc] == 0:
                    pattern[acc] = 1
                    break
        if pattern.hash() != Main.inst.desired_sequence.hash():
            break
    set_pattern(pattern)
            
func set_pattern(pattern: Array[int]):
    for i in len(pattern):
        $Accessories.get_child(i).visible = pattern[i] == 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var mv := speed * delta
    var tl := top_left.global_position + mv
    var bl := bottom_left.global_position + mv
    if tl.x <= Main.inst.left_boundary.global_position.x:
        scale.x *= -1
        speed.x *= -1
    elif tl.x >= Main.inst.right_boundary.global_position.x:
        scale.x *= -1
        speed.x *= -1
    if tl.y <= Main.inst.left_boundary.global_position.y:
        speed.y *= -1
    elif bl.y >= Main.inst.right_boundary.global_position.y:
        speed.y *= -1
    position += mv

func fade_away() -> void:
    var tween := create_tween()
    tween.tween_property(self, "modulate:a", 0, randf_range(0.4, 0.6))
    tween.tween_callback(queue_free)
