extends KinematicBody2D

const MAX_SPEED = 300
const ACCELERATION = 6000
const FRICTION = 2000

var velocity = Vector2.ZERO
var key
var has_key: bool = false

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
	var angle = self.get_local_mouse_position().angle()
	
	if angle > -1 and angle < 1:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("RIGHTWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("RIGHT")
	if angle > 2 or angle < -2:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("LEFTWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("LEFT")
	if angle > -2 and angle < -1:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("UPWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("UP")
	if angle > 1 and angle < 2:
		if input.x != 0 or input.y != 0:
			$AnimatedSprite.play("DOWNWALK")
		elif input == Vector2.ZERO:
			$AnimatedSprite.play("DOWN")
		
func move():
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy") and not body.dead:
		if has_key:
			key.transfer_ownership(body)
			has_key = false
