extends Area2D

onready var player = Globals.player;
onready var PressE = get_node("../PressE");

func _physics_process(delta):
	if !player.canInteract and overlaps_body(player):
		player.canInteract = true;
		PressE.visible = true;
	if player.canInteract and !overlaps_body(player):
		player.canInteract = false;
		PressE.visible = false;
			
	if player.canInteract and overlaps_body(player):
		if Input.is_action_just_released("ui_select"):
			get_parent().start_dialog();
