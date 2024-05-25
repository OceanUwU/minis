extends Node2D


func _on_area_2d_body_entered(body:Node2D):
    if body is RigidBody2D:
        body.queue_free()
        $Recipe.eat(body.name)
