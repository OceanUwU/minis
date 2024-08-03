extends Node2D

signal dropped

@export var colour: Color
var mousing: bool = false
var holding: bool = false
var peg: Node
var main: Node
var available_pegs = []

func _ready():
    peg = get_parent()
    main = peg.get_parent()

func _process(_delta):
    queue_redraw()
    if holding:
        global_position = get_global_mouse_position()

func _draw():
    draw_circle(Vector2.ZERO, 16.0, colour)

func _unhandled_input(event):
    if mousing && event is InputEventMouseButton:
        holding = event.is_pressed()
        if holding:
            $In.play()
        available_pegs = []
        if can_jump(-1, 0, -2, 0):
            available_pegs.append(main.pegs[peg.x-2][peg.y])
        if can_jump(1, 0, 2, 0):
            available_pegs.append(main.pegs[peg.x+2][peg.y])
        if can_jump(0, -1, 0, -2):
            available_pegs.append(main.pegs[peg.x][peg.y-2])
        if can_jump(0, 1, 0, 2):
            available_pegs.append(main.pegs[peg.x][peg.y+2])
        for p in available_pegs:
            p.available = holding
        if !holding:
            for avpeg in available_pegs:
                if global_position.distance_to(avpeg.global_position) < 16:
                    peg.remove_child(self)
                    avpeg.add_child(self)
                    var dist = Vector2(avpeg.x - peg.x, avpeg.y - peg.y)
                    print(main.pegs[peg.x + int(dist.x / 2)][peg.y + int(dist.x / 2)])
                    print(peg.x + int(dist.x / 2), " ", peg.y + int(dist.y / 2))
                    var rem_marble = main.pegs[peg.x + int(dist.x / 2)][peg.y + int(dist.y / 2)].get_child(0)
                    rem_marble.get_child(0).queue_free()
                    var pos = rem_marble.global_position
                    rem_marble.get_parent().remove_child(rem_marble)
                    main.add_child(rem_marble)
                    rem_marble.global_position = pos
                    get_tree().create_tween().tween_property(rem_marble, "modulate:a", 0, 0.2)
                    peg = avpeg
                    position = Vector2.ZERO
                    $Out.play()
                    break;
            position = Vector2.ZERO

func can_jump(inbetweenX, inbetweenY, toX, toY) -> bool:
    inbetweenX += peg.x
    inbetweenY += peg.y
    toX += peg.x
    toY += peg.y
    if inbetweenX >= 0 and inbetweenX < 7 and inbetweenY >= 0 and inbetweenY < 7 and toX >= 0 and toX < 7 and toY >= 0 and toY < 7:
        if main.pegs[inbetweenX][inbetweenY] != null && main.pegs[inbetweenX][inbetweenY].filled() && main.pegs[toX][toY] != null && !main.pegs[toX][toY].filled():
            return true
    return false

func _on_area_2d_mouse_entered():
    mousing = true

func _on_area_2d_mouse_exited():
    mousing = false
