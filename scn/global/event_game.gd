extends Node


signal eventDispatched(name_txt)
signal player_move
signal player_stop
signal player_dead
signal stamina_update
#signal player_dammage(global_hurted,current_hurting)
signal player_do_dammage(int)

signal player_stamina_loose(int)
signal player_stamina_gain(int)

signal focus_on(Vector2)

var player_max_stamina := 10
var player_stamina := 10 : 
	set(value):
		player_stamina = max(-1,min(value,player_max_stamina))
		stamina_update.emit()
		
var player_dammage_done = 0
var dammage_done_during_shoot = 0

func dispatch_event(event_name):
	eventDispatched.emit(event_name)
	
