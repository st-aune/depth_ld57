extends Line2D


@onready var player : Player = $"../Player"

func _physics_process(delta: float) -> void:
	if player.state == Player.EState.STOPPED:
		visible = true
		var to_draw = [player.position] + $"../Player/inputHandler".next_two_impact
		points = PackedVector2Array(to_draw)
	else :
		visible = false
