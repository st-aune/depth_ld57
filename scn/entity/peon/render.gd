extends Node2D

func _ready() -> void:
	if $"..".destroy_on_hit:
		$Polygon2D/Polygon2D2.visible = false
		$Polygon2D.modulate = Color(1.0,1.0,1.0,0.8)
	$"..".activity.connect(set_visible_act)
	$"..".bounce.connect(squash)
func set_visible_act(value):
	if value:
		modulate = Color(1.0,1.0,1.0,1.0)
	else:
		modulate = Color(1.0,1.0,1.0,0.1)

func squash():
	scale = Vector2(1.2,0.8)
	create_tween().tween_property(self,"scale",Vector2.ONE,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
