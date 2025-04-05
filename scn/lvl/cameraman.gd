extends Node2D

@export var target : RigidBody2D :
	set(value):
		target = value
		if target.has_signal("teleported"):
			target.teleported.connect(hard_reset)

@export var cam_dead_zone := 200
@export var speed := 3
var follow := true

var to_go := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target == null:
		target = get_tree().get_first_node_in_group("player")

	cam_dead_zone = cam_dead_zone

func hard_reset(pos):
	# Force to center to player
	global_position = pos
	to_go = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	if target == null:
		return
	position.y = lerp(position.y,to_go.y,delta*speed)
	var target_pos = target.position
	if abs(position.y - target_pos.y) < cam_dead_zone:
		follow = false
	else: 
		follow = true
	if not follow:
		return
	
	to_go = target.position 
	
