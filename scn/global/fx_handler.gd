extends Node2D

@onready var fx_line := preload("res://scn/fx_line.tscn")


func draw_a_line(who,from,to):
	var instance := fx_line.instantiate()
	who.get_parent().add_child(instance)
	instance.global_position = Vector2(0,0)
	instance.scale = Vector2.ONE
	
	instance.points = [from,to]
	instance.get_child(0).points = [from,to]
	get_tree().create_timer(0.5).timeout.connect(instance.queue_free)
	print("ui")
