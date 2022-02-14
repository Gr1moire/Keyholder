extends KinematicBody2D

export var MAX_SPEED = 300
export var ACCELERATION = 6000
export var FRICTION = 2000
var canInteract = false;

var velocity = Vector2.ZERO
var key
var has_key: bool = false

var x_percent
var mouse_position
var screen_width

func _ready():
	key = Globals.key
	Globals.player = self;

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION *delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)	

	handle_mouse(input_vector)
	move()

func handle_mouse(input):
	mouse_position = get_viewport().get_mouse_position()
	screen_width = global_position.x
	print(input)
	if mouse_position.x > screen_width:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("RIGHTWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("RIGHT")
			
	else:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("LEFTWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("LEFT")

		
func move():
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy") and not body.dead:
		if has_key:
			key.transfer_ownership(body)
			has_key = false
