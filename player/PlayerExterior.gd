extends KinematicBody2D

const MAX_SPEED = 300
const ACCELERATION = 6000
const FRICTION = 2000
 
var canMove = false
var canInteract = false
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var keep_direction: String

func _ready():
	Globals.player = self

func _physics_process(delta):
	if canMove:
		input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_vector = input_vector.normalized()

		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION *delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

		move_animation()
		idle_animation()
		move()

func move():
	velocity = move_and_slide(velocity)

func idle_animation():
	if input_vector == Vector2.ZERO and canMove:
		if keep_direction == "RIGHT":
			$AnimatedSprite.play("IDLERIGHT")
		if keep_direction == "LEFT":
			$AnimatedSprite.play("IDLELEFT")
		if keep_direction == "UP":
			$AnimatedSprite.play("IDLEUP")
		if keep_direction == "DOWN":
			$AnimatedSprite.play("IDLEDOWN")

func move_animation():
	if input_vector.x == 1:
		$AnimatedSprite.play("WALKRIGHT")
		keep_direction = "RIGHT"
	elif input_vector.x == -1:
		$AnimatedSprite.play("WALKLEFT")
		keep_direction = "LEFT"
	elif input_vector.y == 1:
		$AnimatedSprite.play("WALKDOWN")
		keep_direction = "DOWN"
	elif input_vector.y == -1:
		$AnimatedSprite.play("WALKUP")
		keep_direction = "UP"
