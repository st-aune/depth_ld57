extends Node2D


func _ready() -> void:
	$"../..".bounce.connect(play_bounce)
	$"../..".move.connect(play_bounce)
	GameManager.player_stamina_loose.connect(play_hurt)

func play_bounce():
	scale = Vector2(1.3,0.7)
	create_tween().tween_property(self,"scale",Vector2.ONE,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

func play_hurt():
	scale = Vector2(0.5,1.5)
	create_tween().tween_property(self,"scale",Vector2.ONE,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func play_idle():
	pass
