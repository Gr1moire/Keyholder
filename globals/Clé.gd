extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var attached_to: Node2D = null

var delayed_pos_list: Array = []
var delayed_pos_delay: int = 20

## Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Set position to mouse position
	if (attached_to):
		delayed_pos_list.append(attached_to.position)
		if (delayed_pos_list.size() >= delayed_pos_delay):
			self.position = delayed_pos_list.pop_front()
	else:
		self.position = self.get_viewport().get_mouse_position()

func _on_RigidBody2D_body_entered(body):
	if body.is_in_group("Player"):
		attached_to = body
		self.position = attached_to.position
