extends Control

var pos_a : Vector2
var pos_a2 : Vector2

func _ready() -> void:
	GameManager.eventDispatched.connect(on_event)
	pos_a = $Blakc/PanelA.position
	pos_a2 = $Blakc/PanelA2.position

func on_event(event_name):
	if event_name == "GAMEOVER":
		anim_game_over()
	if event_name == "RESTART":
		reset_anim()

func reset_anim():
	$Blakc.visible = false
	$gameover_msg.visible = false
	$restart.visible = false
	$Blakc/PanelA.position = pos_a
	$Blakc/PanelA2.position = pos_a2
	visible = false
func anim_game_over():
	reset_anim()
	visible = true
	
	$Blakc.visible = true
	create_tween().tween_property($Blakc/PanelA,"position",Vector2.ZERO - $Blakc/PanelA.pivot_offset,0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	await create_tween().tween_property($Blakc/PanelA2,"position",Vector2.ZERO- $Blakc/PanelA2.pivot_offset,0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN).finished
	$gameover_msg.visible = true
	$gameover_msg.scale = Vector2(0.2,2.0)
	await create_tween().tween_property($gameover_msg,"scale",Vector2.ONE,0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT).finished
	$restart.visible = true
	$restart.scale = Vector2(0.2,2.0)
	await create_tween().tween_property($restart,"scale",Vector2.ONE,0.5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT).finished
	
