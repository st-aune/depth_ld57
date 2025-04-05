extends StaticBody2D

@export var stamina_per_hit := 1
@export var destroy_on_hit := true

var _active_at_start : bool
var _monitoring_at_start : bool

func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_collide,CONNECT_DEFERRED)
	_active_at_start = $CollisionShape2D.disabled
	_monitoring_at_start = $Area2D.monitoring
	GameManager.player_stop.connect(reset)
func _on_player_collide(body: Node2D):
	if not(body is Player):
		return
	GameManager.player_stamina += stamina_per_hit
	if destroy_on_hit:
		await get_tree().create_timer(0.05).timeout
		$Area2D.monitoring = false
		$CollisionShape2D.disabled = true
		
func reset():
	$Area2D.monitoring = _monitoring_at_start
	$CollisionShape2D.disabled = _active_at_start
