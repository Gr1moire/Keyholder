extends KinematicBody2D
	

export(int) var SPEED: int = 300
var velocity: Vector2 = Vector2.ZERO

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
var dead = false
var key
var has_key: bool = false

func _ready():
	key = Globals.key
	var tree = get_tree()
	if tree.has_group("LevelNavigation"): 
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]

func _physics_process(delta):
	
	$Line2D.global_position = Vector2.ZERO
	if player and levelNavigation and not dead:
		generate_path()
		navigate()
	if not dead:
		move()

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		
		if has_key:
			velocity = -velocity
		
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		$Line2D.points = path

func move():
	velocity = move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet") and not dead:
		trigger_death()
		if has_key:
			key.attached_to = null

func trigger_death():
	$Particles2D.emitting = true
	$ColorRect.visible = false
	$CollisionShape2D.queue_free()
	dead = true
	yield(get_tree().create_timer(1.25), "timeout");
	queue_free();
