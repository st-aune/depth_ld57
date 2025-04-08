extends Node2D


func _ready() -> void:
	$"../..".bounce.connect(play_bounce)
	$"../..".move.connect(play_bounce)
	$"../..".move.connect($"../explo".restart)
	GameManager.player_stamina_loose.connect(play_hurt)
	$"../..".stoped.connect(play_idle)
func play_bounce():
	scale = Vector2(1.7,0.3)
	create_tween().tween_property(self,"scale",Vector2.ONE,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	hide_emoji()
	$Yeuxouvert.visible = true
	update_color()
func play_hurt():
	scale = Vector2(0.5,0.5)
	create_tween().tween_property(self,"scale",Vector2.ONE,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	hide_emoji()
	$Pleur.visible = true
	update_color()
func hide_emoji():
	$Yeuxferme.visible = false
	$Yeuxouvert.visible = false
	$Pleur.visible = false
	update_color()
func play_idle():
	hide_emoji()
	$Yeuxferme.visible = true
	update_color()
	
func update_color():
	if GameManager.player_stamina <= 1:
		modulate = Color.hex(0x655366ff)
	else:
		modulate = Color.WHITE
