extends Area2D


func _ready() -> void:
	body_entered.connect(checkpoint_passed,CONNECT_DEFERRED)

func checkpoint_passed(foo):
	if not(foo is Player):
		return
	monitoring = false
	monitorable = false
	$Label.visible = true
	$Label.visible_ratio = 0
	GameManager.checkpoint = global_position
	await create_tween().tween_property($Label,"visible_ratio",1.0,0.5).finished
	await get_tree().create_timer(1.0).timeout
	create_tween().tween_property($Label,"visible_ratio",0.0,0.5).finished
