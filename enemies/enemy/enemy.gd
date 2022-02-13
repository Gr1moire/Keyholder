extends KinematicBody2D
	

export(int) var SPEED: int = 200
var velocity: Vector2 = Vector2.ZERO

const run_point = [	Vector2(105, 105),
					Vector2(490, 105),
					Vector2(950, 105),
					Vector2(950, 300),
					Vector2(950, 520),
					Vector2(500, 520),
					Vector2(100, 520),
					Vector2(100, 300)]

const run_point_2 = [	Vector2(72, 268),
						Vector2(257, 129),
						Vector2(370, 413),
						Vector2(672, 409),
						Vector2(801, 126),
						Vector2(950, 294),
						Vector2(526, 106)]

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var dead = false
var key
var has_key: bool = false
var near_point: bool = true
var flee_point: float = 0
var is_disabled: bool = false
var scene_name

var rng = RandomNumberGenerator.new()

func _ready():
	scene_name = get_tree().current_scene.name
	$AnimatedSprite.play("wak")
	rng.randomize()
	key = Globals.key
	var tree = get_tree()
	if tree.has_group("LevelNavigation"): 
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]

func _physics_process(delta):

	if scene_name == "Level1":
		if global_position.distance_to(run_point[flee_point]) < 50:
			near_point = true
	elif scene_name == "Level2":
		if global_position.distance_to(run_point_2[flee_point]) < 50:
			near_point = true

	if has_key:
		if near_point:
			flee_point = get_best_flee()
			near_point = false
		if not is_disabled:
			$Collision.disabled = true
			is_disabled = true
	
	if player and levelNavigation:
		generate_path()
		navigate()
	if not dead:
		move()

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED	
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		if has_key:
			if scene_name == "Level1":
				path = levelNavigation.get_simple_path(global_position, run_point[flee_point], false)
			elif scene_name == "Level2":
				path = levelNavigation.get_simple_path(global_position, run_point_2[flee_point], false)
		else:
			path = levelNavigation.get_simple_path(global_position, player.global_position, false)

func move():
	velocity = move_and_slide(velocity)

func get_best_flee():
	if scene_name == "Level1":
		return rng.randf_range(0, 7)
	elif scene_name == "Level2":
		return rng.randf_range(0, 6)

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet") and not dead:
		trigger_death()
		if has_key:
			key.attached_to = null

func trigger_death():
	$Particles2D.emitting = true
	$AnimatedSprite.visible = false
	$Collision.queue_free()
	Globals.camera.shake(0.2, 15, 8)
	dead = true
	$AnimationPlayer.play("Shrink light")
	yield(get_tree().create_timer(0.5), "timeout");
	queue_free();
