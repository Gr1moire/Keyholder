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

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var key
var has_key: bool = false
var near_point: bool = true
var flee_point: float = 0

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	key = Globals.key
	var tree = get_tree()
	if tree.has_group("LevelNavigation"): 
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]
		

func _physics_process(delta):
	$Line2D.global_position = Vector2.ZERO
	
	if global_position.distance_to(run_point[flee_point]) < 50:
		near_point = true
	
	if has_key:
		if near_point:
			flee_point = get_best_flee()
			near_point = false
	
	if player and levelNavigation:
		generate_path()
		navigate()
	move()
	
func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED	
		if global_position == path[0]:
			path.pop_front()
	
func generate_path():
	if levelNavigation != null and player != null:
		if has_key:
			path = levelNavigation.get_simple_path(global_position, run_point[flee_point], false)
		else:
			path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		$Line2D.points = path

func move():
	velocity = move_and_slide(velocity)

func get_best_flee():
	return rng.randf_range(0, 7)

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		queue_free()
		if has_key:
			key.attached_to = null
