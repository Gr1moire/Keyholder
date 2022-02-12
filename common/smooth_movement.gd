extends Node2D

export(float, 0, 5) var SMOOTH_SPEED: float = 3

func move(dest: Vector2, delta: float = 0.1):
	var pos_diff = dest - self.position
	var smoothed_velocity = pos_diff * SMOOTH_SPEED * delta
	self.position += smoothed_velocity
