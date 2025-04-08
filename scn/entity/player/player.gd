extends RigidBody2D
class_name Player

signal move
signal bounce
signal done
signal stoped
signal dead

var n_bounce = 0

@export var default_force := 1000.0
enum EState {MOVING, STOPPED, DEAD}


var _colliding_bd := 0

var state = EState.STOPPED : 
	set(value) : 
		if state == value:
			return
		state = value
		if state == EState.MOVING:
			move.emit()
		if state == EState.STOPPED:
			stoped.emit()
			GameManager.player_stop.emit()
		if state == EState.DEAD:
			freeze = true
			GameManager.dispatch_event("GAMEOVER")
			dead.emit()


func on_no_more_stamina():
	state = EState.DEAD

func _ready() -> void:
	stop()
	move.connect(GameManager.player_move.emit)
	GameManager.no_more_stamina.connect(on_no_more_stamina)
func go(impulse_dir : Vector2,impulse_force : float  = -1 ):
	print("GO")
	gravity_scale = 0.0
	n_bounce = 0
	freeze = false
	if impulse_force < 0 :
		impulse_force = default_force
	GameManager.player_stamina -= 1
	apply_impulse(impulse_dir.normalized() * impulse_force)
	state = EState.MOVING

func _process(delta: float) -> void:
	$Label.text = str(state)


func _physics_process(delta: float) -> void:
	if _colliding_bd < get_contact_count():
		on_boing(get_colliding_bodies())
		bounce.emit()
	_colliding_bd = get_contact_count()
	if state == EState.MOVING:
		%pivot.look_at(position +  linear_velocity)

func on_boing(bodies):
	print(bodies)
	if n_bounce == 0:
		gravity_scale = 1.0
	n_bounce +=1 
	
	


func stop():
	if state == EState.STOPPED:
		return
	freeze = true
	if GameManager.player_stamina <= 0:
		state = EState.DEAD
		return
	state = EState.STOPPED
	
