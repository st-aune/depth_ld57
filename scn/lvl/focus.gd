extends Node2D

@export var zoom:= 1.0

func _ready() -> void:
	$Area2D.body_entered.connect(GameManager.focus_on.emit.bind(global_position).unbind(1))
	$Area2D.body_entered.connect(GameManager.zoom_at.emit.bind(zoom).unbind(1))
