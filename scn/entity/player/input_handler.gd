extends Node2D

enum EINPUT {MOUSE,JOY}

var input_mode = EINPUT.MOUSE
@export var lag_dir := 50.0

@onready var player_ray := $"../pivot/ray"
@export var second_ray : RayCast2D

var last_dir := Vector2.ONE
var direction
var mouspos : Vector2 = Vector2.ZERO
@onready var player :Player = $".."
var next_two_impact := [Vector2.ZERO,Vector2.ZERO]

func _ready():
	mouspos = get_global_mouse_position()
	second_ray = get_tree().get_first_node_in_group("raycaster")
	
func restart():
	if GameManager.game_state == GameManager.EGameState.RESPAWNING:
		return
	GameManager.respawn()
	GameManager.player_stamina = 3
	player.global_position = GameManager.checkpoint
	GameManager.focus_on.emit(player.global_position)
	await get_tree().create_timer(0.8).timeout
	player.state = Player.EState.STOPPED
	GameManager.game_state = GameManager.EGameState.PLAY
	GameManager.dispatch_event("RESTART")
	
func _process(delta):
	if GameManager.game_state == GameManager.EGameState.RESPAWNING:
		return
	if Input.is_action_just_pressed("restart"):
		player.state = Player.EState.DEAD
		restart.call_deferred()
		return
	if player.state == Player.EState.DEAD:
		if Input.is_action_just_pressed("action"):
			restart.call_deferred()
		return
	if Input.is_action_just_pressed("action"):
		print("Action stop")
		player.stop()
	if  Input.is_action_just_released("action"):
		player.go(direction)
	if player.state == Player.EState.MOVING:
		return
	var new_dir := Vector2.ZERO
	#if (get_global_mouse_position() - mouspos).length_squared() > 1.0:
		#new_dir = get_global_mouse_position() - global_position
		#mouspos = get_global_mouse_position()
	new_dir = get_global_mouse_position() - get_parent().global_position
	#new_dir += Input.get_vector("left", "right", "up", "down")
	last_dir = new_dir #lerp(last_dir+Vector2.ONE*0.001,new_dir, delta * lag_dir)
	
	direction = last_dir.normalized()
	%pivot.look_at(get_global_mouse_position())
	player_ray.force_raycast_update()
	if player_ray.is_colliding():
		
		next_two_impact[0] = player_ray.get_collision_point()  # global_position + (player_ray.get_collision_point()-global_position)*0.99
		var ray_direction = (player_ray.get_collision_point() - global_position)
		var ray_norm  = player_ray.get_collision_normal().normalized()
		var rayprojection = 2*(ray_direction-ray_direction.dot(ray_norm)*ray_norm)
	
		
		second_ray.global_position = to_global((player_ray.get_collision_point()-global_position)*0.99)
		second_ray.target_position = (to_global(rayprojection) - second_ray.global_position).normalized() * 5000
		second_ray.force_raycast_update()
		if second_ray.is_colliding():
			next_two_impact[1] = second_ray.get_collision_point()
		else:
			next_two_impact[1] = next_two_impact[0]
			

	
