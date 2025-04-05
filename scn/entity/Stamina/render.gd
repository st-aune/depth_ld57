extends Node2D


func _ready() -> void:
	if $"..".destroy_on_hit:
		$Polygon2D/Polygon2D2.visible = false
		$Polygon2D.modulate = Color(1.0,1.0,1.0,0.5)
	$"..".activity.connect(set_visible_act)

func set_visible_act(value):
	if value:
		modulate = Color(1.0,1.0,1.0,1.0)
	else:
		modulate = Color(1.0,1.0,1.0,0.1)
