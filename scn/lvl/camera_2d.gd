extends Camera2D

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var force = 0.0  # Current shake strength.
var force_power = 2  # Trauma exponent. Use [2, 3].

func _ready() -> void:
	print("subscribe")
	GameManager.eventDispatched.connect(handleEvent,CONNECT_DEFERRED)
	#GameManager.player_stamina_loose.connect(doShake.bind(0.3))
	GameManager.player_do_dammage.connect(doShakedFoo.bind(0.15))
	GameManager.player_stamina_gain.connect(doShake.bind(0.15))
	GameManager.zoom_at.connect(zoom_at)

func zoom_at(zoom_factor):
	create_tween().tween_property(self,"zoom",Vector2.ONE * zoom_factor,1.0)

	
func doShakedFoo(foo, amount):
	doShake(amount)

func handleEvent(event_name):
	print("receive " + event_name)
	if event_name == "DAMAGED":
		Engine.time_scale = 0.3
		await get_tree().create_timer(0.05,true,false,true).timeout
		Engine.time_scale = 1.0
		doShake(0.2)
		
	if event_name == "coup_fatal":
		doShake(0.3)
	if event_name == "RESTART":
		position = Vector2.ZERO
func doShake(amount=0.5):
	force = min(force + amount, 0.2)

func shake():
	var amount = pow(force, force_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

func _process(delta):
	if force and Engine.time_scale>0.5:
		force = max(force - decay * delta, 0)
		shake()
