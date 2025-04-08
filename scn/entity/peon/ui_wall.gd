extends Control

var time_range := 0.5

var text_label_int : int = 0 :
	set(value) :
		text_label_int = value 
		$NodeLabel/Label.text = str($"..".initial_pv-text_label_int) + "/" + str($"..".initial_pv)
		squash_text()
		
func _ready() -> void:
	$feedback.max_value = $"..".initial_pv
	$PV.max_value = $"..".initial_pv
	updated_pv($"..".pv)
	$"..".wall_damaged.connect(updated_pv)


func updated_pv(new_pv):
	create_tween().tween_property($PV,"value",new_pv,time_range*0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	create_tween().tween_property($feedback,"value",new_pv,time_range).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	create_tween().tween_property(self,"text_label_int",new_pv,time_range*1.0)

func squash_text():
	$NodeLabel.scale = Vector2(1.4,1.1)
	#await create_tween().tween_property($NodeLabel,"scale",Vector2(1.4,1.1),time_range*0.05).finished
	create_tween().tween_property($NodeLabel,"scale",Vector2.ONE*1.0,time_range*0.05)
