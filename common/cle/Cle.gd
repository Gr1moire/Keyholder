extends "res://common/smooth_movement.gd"

# Declare member variables here. Examples:
var attached_to: Node2D = null
export(Array) var group_to_attach_to = ["Player"]

## Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attached_to):
		self.move(attached_to.position, delta)

func transfer_ownership(body: Node2D):
	attached_to = body

func _on_RigidBody2D_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		self.transfer_ownership(body)
		self.move(attached_to.position)
