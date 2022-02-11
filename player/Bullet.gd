extends RigidBody2D

func _on_Area2D_body_entered(body):
	print("je rentre area")
	if !body.is_in_group("player"):
		queue_free()
