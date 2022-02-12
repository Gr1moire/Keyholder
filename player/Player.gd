extends KinematicBody2D

export var MAX_SPEED = 300
export var ACCELERATION = 6000
export var FRICTION = 2000
export var bullet_speed = 1000
export var fire_rate = 0.2

var bullet = preload("res://player/Bullet.tscn")
var can_fire = true

var velocity = Vector2.ZERO
var key
var has_key: bool = false

func _ready():
	key = Globals.key
	pass

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION *delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	

	move()

func move():
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		if has_key:
			key.transfer_ownership(body)
			has_key = false
