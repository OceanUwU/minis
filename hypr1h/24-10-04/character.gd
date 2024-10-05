class_name Character
extends Area2D

@export var items : Array[Texture2D]
@export var speed: float
var animal : String
var end_x: float = 400
var start_x: float
var arrived: bool = false
var returning: bool = false
@export var wait_time: float
var waited_time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    start_x = position.x
    var animals := ["dog", "snail", "duck", "rat"]
    animal = animals[randi() % animals.size()]
    $Sprite.play(animal + "w")
    var wants : Texture2D = items[randi() % items.size()]
    $Sprite/Hold.texture = wants
    $Speech/Wants.texture = wants
    $Speech.hide()
    $Sprite/Hold.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if !arrived:
        position.x += speed * delta
        if position.x >= end_x:
            position.x = end_x
            arrived = true
            $Sprite.play($Sprite.animation.substr(0, len($Sprite.animation) - 1))
            $Speech.show()
    elif returning:
        position.x -= speed * delta
        if position.x < start_x:
            queue_free()
    else:
        waited_time += delta
        $Speech/ProgressBar.value = waited_time / wait_time
        if waited_time > wait_time:
            get_parent().game_over()

func pickup(texture: Texture2D):
    if arrived && !returning && texture == $Speech/Wants.texture:
        $Speech.hide()
        $Sprite/Hold.show()
        scale.x = -1
        $CollisionShape2D.position.y = -10000
        returning = true
        $Sprite.play($Sprite.animation + "w")
        get_parent().satisfy(self)
        
