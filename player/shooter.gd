extends Node2D

export var bullet_speed = 1000
export var fire_rate = 0.2

var bullet = preload("res://player/Bullet.tscn")
var can_fire = true

#Power ups
export var power_fire : bool = false
export var shot_number : int = 3

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		Globals.camera.shake(0.1, 15, 2)	
		var random = rand_range(0, 3)
		match (random):
			1:
				$Shoot1.play()
			2:
				$Shoot2.play()
			_:
				$Shoot3.play()
		if power_fire:
			_power_fire()
		else:
			_standard_fire()
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func _standard_fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.global_position
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)


func _power_fire():

	var bullet_rotation = rotation_degrees - (50 / shot_number);
	var impulse_rotation = rotation - 0.3;
	var bullet_instances = [];
	for i in shot_number:
		bullet_instances.push_back(bullet.instance());
	for instance in bullet_instances:
		instance.position = $BulletPoint.global_position;
		instance.rotation_degrees = bullet_rotation;
		instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(impulse_rotation));
		bullet_rotation += (50 / shot_number);
		impulse_rotation += (0.3 / (shot_number / 2));
	for instance in bullet_instances:
		get_tree().get_root().add_child(instance);
	
		
