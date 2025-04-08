extends Control
var feedback_time := 0.8
var feddback_factor := 0.5


var label_stamina : int = 0 :
	set(value) :
		if label_stamina> value:
			scale = Vector2(1.2,0.8)
			create_tween().tween_property(self,"scale",Vector2.ONE,feedback_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		label_stamina = value 
		$Node2D/RichTextLabel.text = str(label_stamina) + "/" + str(GameManager.player_max_stamina)
		
		
func _ready() -> void:
	update_UI()
	#GameManager.player_move.connect(update_UI)
	GameManager.stamina_update.connect(update_UI)

func update_UI():
	$Stamina.max_value = GameManager.player_max_stamina
	$Stamina_feedback.max_value = GameManager.player_max_stamina
	create_tween().tween_property($Stamina,"value",GameManager.player_stamina,feedback_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	create_tween().tween_property($Stamina_feedback,"value",GameManager.player_stamina,feedback_time*1.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	
	
	#$Stamina.value = GameManager.player_stamina
	#$Stamina_feedback.value = GameManager.player_stamina
	label_stamina = GameManager.player_stamina
	$Node2D.scale = Vector2(1.0-feddback_factor + 0.5,1.0+feddback_factor+0.5)
	create_tween().tween_property($Node2D,"scale",Vector2.ONE,feedback_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
