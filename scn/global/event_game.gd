extends Node

enum EGameState {PLAY,GAMEOVER,RESPAWNING,WIN}
var game_state := EGameState.PLAY

signal eventDispatched(name_txt)
signal player_move
signal player_stop
signal player_dead
signal stamina_update
signal boing

#signal player_dammage(global_hurted,current_hurting)
signal player_do_dammage(int)

signal player_stamina_loose
signal player_stamina_gain
signal player_hitted()
signal focus_on(Vector2)
signal zoom_at(float)
signal player_respawn
signal no_more_stamina
signal gagneeeee

var checkpoint = Vector2.ZERO

var has_win : bool = false

var player_max_stamina := 7
var player_stamina := 7 : 
	set(value):
		if value < player_stamina:
			player_stamina_loose.emit()
		if value > player_stamina:
			player_stamina_gain.emit()
		player_stamina = max(-1,min(value,player_max_stamina))
		if player_stamina == -1 :
			no_more_stamina.emit()
			gameover()
		stamina_update.emit()
		
		
var player_dammage_done = 0
var dammage_done_during_shoot = 0

func dispatch_event(event_name):
	eventDispatched.emit(event_name)

func respawn():
	if (game_state == EGameState.RESPAWNING):
		return
	game_state = EGameState.RESPAWNING
	player_respawn.emit()
	dispatch_event("RESPAWN")

func zoom_request(zoom:float):
	zoom_at.emit(zoom)
func gameover():
	if not(game_state == EGameState.PLAY):
		return
	game_state == EGameState.GAMEOVER
	dispatch_event("GAMEOVER")

func win():
	if not has_win:
		has_win = true
		gagneeeee.emit()

func reload():
	has_win = false
	
	get_tree().reload_current_scene()
