extends Tween

onready var camera = get_node("../../UI/Camera2D");
onready var key = Globals.key;

func _ready():
	if (!camera):
		print("No camera specified");
	if (!key):
		print("No key specified");

func loseAnimation():
	get_tree().paused = true;
	var initialPosition = camera.position;
	var initialZoom = camera.zoom;
	var key_position = Vector2(key.position.x, key.position.y);
	interpolate_property(camera, "position", initialPosition, key_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	interpolate_property(camera, "zoom", initialZoom, Vector2(0.4, 0.4), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	start();
