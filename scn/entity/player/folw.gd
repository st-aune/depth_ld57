extends Node2D

var speed := 10.0
var last_globa_pos := Vector2.DOWN

func _physics_process(delta: float) -> void:
	look_at(last_globa_pos)
	last_globa_pos = lerp(last_globa_pos,global_position,speed*delta)
