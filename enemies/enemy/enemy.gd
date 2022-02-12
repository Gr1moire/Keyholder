extends KinematicBody2D
	

export(int) var SPEED: int = 300
var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var key
var has_key: bool = false

func _ready():
	key = Globals.key
	var tree = get_tree()
	if tree.has_group("LevelNavigation"): 
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]
		

func _physics_process(_delta):
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
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)


func move():
	velocity = move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		queue_free()
		if has_key:
			key.attached_to = null
