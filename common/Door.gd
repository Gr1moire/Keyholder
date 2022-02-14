extends Sprite

var canInteract = false;

func _ready():
	pass

func _physics_process(delta):
	if canInteract and  !$layer/PressE.visible:
		$layer/PressE.visible = true;
	elif not canInteract and $layer/PressE.visible:
		$layer/PressE.visible = false;

func turn_light_on():
	$AnimationPlayer.play("Light appears");
