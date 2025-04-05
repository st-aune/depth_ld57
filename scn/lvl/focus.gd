extends Node2D



func _ready() -> void:
	$Area2D.body_entered.connect(GameManager.focus_on.emit.bind(global_position).unbind(1))
