extends KinematicBody2D

export(int) var SPEED: int = 200

var velocity: Vector2 = Vector2.ZERO
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

signal dead

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

	if scene_name == "Level1" and global_position.distance_to(Globals.run_point[flee_point]) < 50:
		near_point = true
	elif scene_name == "Level2" and global_position.distance_to(Globals.run_point_2[flee_point]) < 50:
		near_point = true
	elif scene_name == "Level3" || scene_name == "LevelEndless" and global_position.distance_to(Globals.run_point_3[flee_point]) < 50:
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
				path = levelNavigation.get_simple_path(global_position, Globals.run_point[flee_point], false)
			elif scene_name == "Level2":
				path = levelNavigation.get_simple_path(global_position, Globals.run_point_2[flee_point], false)
			elif scene_name == "Level3" || scene_name == "LevelEndless":
				path = levelNavigation.get_simple_path(global_position, Globals.run_point_3[flee_point], false)
				
		else:
			path = levelNavigation.get_simple_path(global_position, player.global_position, false)

func move():
	velocity = move_and_slide(velocity)

func get_best_flee():
	if scene_name == "Level1" or scene_name == "Level3" or scene_name == "LevelEndless":
		return rng.randf_range(0, 7)
	elif scene_name == "Level2":
		return rng.randf_range(0, 6)

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet") and not dead:
		$LifeController.took_damage(1)
		if $LifeController.life == 0:
			trigger_death()
			if has_key:
				key.attached_to = null
		else:
			var tmp_modulate = $AnimatedSprite.modulate
			$AnimatedSprite.modulate = Color(255, 255, 255, 1)
			yield(get_tree().create_timer(0.2), "timeout");
			$AnimatedSprite.modulate = tmp_modulate

func trigger_death():
	$Particles2D.emitting = true
	$AnimatedSprite.visible = false
	$Collision.queue_free()
	$DeathSound.play()
	Globals.camera.shake(0.2, 15, 8)
	dead = true
	$AnimationPlayer.play("Shrink light")
	emit_signal("dead")
	yield(get_tree().create_timer(0.5), "timeout");
	queue_free();
