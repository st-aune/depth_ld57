extends StaticBody2D

signal wall_died
signal wall_damaged(int)
@export var initial_pv := 5
@export var pv := 5

func _ready() -> void:
	#GameManager.player_do_dammage.connect(on_dammaged,CONNECT_DEFERRED)
	for node in get_parent().get_children():
		if node is dammage_bloc:
			node.doing_dammage.connect(bloc_dammage.bind(node))
	
func bloc_dammage(dammage,who):
	print(dammage)
	print(who)
	GameManager.get_node("FX_handler").draw_a_line(self,global_position,
		get_tree().get_first_node_in_group("player").global_position)
	on_dammaged(dammage)

func on_dammaged(amount):
	print("as wall I received dammage")
	pv -= amount
	wall_damaged.emit(pv)
	if pv < 0:
		wall_died.emit()
		queue_free()
