extends Node2D

export var bullet_speed = 1000
export var fire_rate = 0.2

var bullet = preload("res://player/Bullet.tscn")
var can_fire = true

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		Globals.camera.shake(0.1, 15, 2)
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
