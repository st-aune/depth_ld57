extends Area2D


func _ready() -> void:
	body_entered.connect(check_bd)

func check_bd(bod):
	if bod is Player:
		GameManager.win()
