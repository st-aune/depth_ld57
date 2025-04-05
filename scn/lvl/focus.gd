extends Node2D



func _ready() -> void:
	$Area2D.body_entered.connect(GameManager.camera_look(global_position))
