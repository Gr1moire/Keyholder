extends Tween

export (NodePath) var camera = null;
onready var globalCamera = get_node("../../UI/Camera2D");

func _ready():
	if (!globalCamera):
		print("No camera specified");
	if (!camera):
		print("No player camera specified");

func introAnimation():
	var cameraNode = get_node(camera)
	cameraNode.followPlayer = false;
	var initialPosition = cameraNode.position;
	var initialZoom = cameraNode.zoom;
	var initialOffsetH = cameraNode.offset_h;
	var initialOffsetV = cameraNode.offset_v;
	var globalCameraPosition = globalCamera.get_global_transform();
	var globalCameraZoom = globalCamera.zoom;
	var globalCameraOffsetH = globalCamera.offset_h;
	var globalCameraOffsetV = globalCamera.offset_v;
	interpolate_property(cameraNode, "transform", initialPosition, globalCamera.get_global_transform(), 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	interpolate_property(cameraNode, "zoom", initialZoom, globalCamera.zoom, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	interpolate_property(cameraNode, "offset_h", initialOffsetH, globalCamera.offset_h, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	interpolate_property(cameraNode, "offset_v", initialOffsetV, globalCamera.offset_v, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);

	start();
