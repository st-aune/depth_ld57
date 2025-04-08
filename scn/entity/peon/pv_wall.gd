extends StaticBody2D
class_name PVWall
signal wall_died
signal wall_damaged(int)
@export var initial_pv := 5
@export var pv := 5
var died = false
func _ready() -> void:
	reset()
	#GameManager.player_do_dammage.connect(on_dammaged,CONNECT_DEFERRED)
	for node in get_parent().get_children():
		if node is dammage_bloc:
			node.doing_dammage.connect(bloc_dammage.bind(node))
	GameManager.player_respawn.connect(reset)
	
	
func bloc_dammage(dammage,who):
	print(dammage)
	print(who)
	GameManager.get_node("FX_handler").draw_a_line(self,global_position,
		get_tree().get_first_node_in_group("player").global_position)
	on_dammaged.call_deferred(dammage)

func reset():
	pv = initial_pv

func on_dammaged(amount):
	
	print("as wall I received dammage")
	pv -= amount
	wall_damaged.emit(pv)
	if pv <= 0:
		if died :
			return
		died = true
		wall_died.emit()
		get_tree().create_timer(0.2).timeout.connect(wall_damaged.emit.bind(pv))
		get_tree().create_timer(0.75).timeout.connect(queue_free)
