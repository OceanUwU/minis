extends Node2D

var stars := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for i in 50:
        stars.append({
            "x": randf_range(0, 1300),
            "y": randf_range(0, 700),
            "vel": randf_range(5, 50),
            "size": randf_range(1, 4)
        })

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    for star in stars:
        star.x -= star.vel * delta
        if star.x < -50:
            star.x = 1300
    queue_redraw()

func _draw() -> void:
    for star in stars:
        draw_circle(Vector2(star.x, star.y), star.size, Color.WHITE)
