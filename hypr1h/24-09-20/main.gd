extends Node

@export var hrt_scene: PackedScene
@export var duck_scene: PackedScene
var num_hearts := 1
var alive := true
var time := 50.0
var spawn_timer = 0.0
var heart_there := false

func _ready() -> void:
    fling()

func _process(delta: float) -> void:
    $Catap/Line2D.points[0] = $Catap/HeartPos.position - Vector2(50, 0)
    $Catap/Line2D2.points[0] = $Catap/HeartPos.position - Vector2(50, 0)
    if alive:
        time -= delta
        if time <= 0.0:
            time = 0.0
            lose()
        $Timer.text = "%.1fs" % time
        spawn_timer -= delta
        if spawn_timer < 0:
            spawn_timer += 1.987
            add_child(duck_scene.instantiate())
            

func lose():
    alive = false
    $Label.show()

func fling():
    heart_there = false
    if num_hearts > 0 && alive:
        num_hearts -= 1
        $Num.text = str(num_hearts)
        add_child(hrt_scene.instantiate())
        heart_there = true
    
func gain_heart():
    if alive:
        num_hearts += 1
        if num_hearts == 1 && !heart_there:
            heart_there = true
            add_child(hrt_scene.instantiate())
            num_hearts -= 1
        $Num.text = str(num_hearts)

func _on_button_pressed() -> void:
    get_tree().reload_current_scene()
