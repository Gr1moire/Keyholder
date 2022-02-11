extends Node2D

export(Vector2) var screenSize = Vector2(1920.0, 1080.0)
export(float) var extendedCameraDivider = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$Camera2D.offset_h = (mouse_pos.x - global_position.x) / (screenSize.x / extendedCameraDivider)
	$Camera2D.offset_v = (mouse_pos.y - global_position.y) / (screenSize.y / extendedCameraDivider)
	$Camera2D.offset = Vector2($Camera2D.offset_h, $Camera2D.offset_v)
