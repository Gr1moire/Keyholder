extends "res://common/smooth_movement.gd"

# Declare member variables here. Examples:
var attached_to: Node2D = null
export(Array, String) var group_to_attach_to = ["Player"]
var tmp

## Called when the node enters the scene tree for the first time.
func _ready():
	Globals.key = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attached_to):
		self.move(attached_to.position, delta * 2.3)

func transfer_ownership(body: Node2D):
	attached_to = body
	body.has_key = true

func _on_RigidBody2D_body_entered(body: Node2D):
	for group in group_to_attach_to:
		if body.is_in_group(group):
			self.transfer_ownership(body)
			self.move(attached_to.position)
