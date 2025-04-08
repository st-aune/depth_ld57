extends Control

var t := 0.0
func _ready() -> void:
	GameManager.zoom_at.connect(onzoom)
	GameManager.gagneeeee.connect(on_win,CONNECT_DEFERRED)
	$Button.pressed.connect(GameManager.reload)
func onzoom(factor):
	create_tween().tween_property(self,"scale",1.0/factor * Vector2.ONE,1.0)

func _physics_process(delta: float) -> void:
	if not GameManager.has_win:
		t += delta * 1000
		var minutes = int(t / 60 / 1000)
		var seconds = int(t / 1000) % 60
		var miliseconds = int(t) % 1000

		$timer.text = "[code]" + ("%02d" % minutes) + (":%02d" % seconds) + (":%03d" % miliseconds) +"[/code]"

func on_win():
	$Win.visible = true
	$timer.visible = false
	$Win/timer.visible = false
	$Win/RichTextLabel.visible_ratio = 0
	
	await create_tween().tween_property($timer,"global_position",$Win/pin.global_position,0.2).finished
	create_tween().tween_property($timer,"scale",Vector2.ONE*1.3,0.2).set_trans(Tween.TRANS_ELASTIC)
	var minutes = int(t / 60 / 1000)
	var seconds = int(t / 1000) % 60
	var miliseconds = int(t) % 1000
	await create_tween().tween_property($Win/RichTextLabel,"visible_ratio",1.0,0.5).finished
	await create_tween().tween_property($Win/RichTextLabel,"scale",Vector2.ONE*1.2,0.5).set_trans(Tween.TRANS_ELASTIC).finished
	$Win/timer.visible = true
	$Win/timer.text =  "YOUR TIME: [code]" + ("%02d" % minutes) + (":%02d" % seconds) + (":%03d" % miliseconds) +"[/code]"
	
	await create_tween().tween_property($Win/RichTextLabel,"scale",Vector2.ONE*1.2,0.5).set_trans(Tween.TRANS_ELASTIC).finished
	
