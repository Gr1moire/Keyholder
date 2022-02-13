extends Area2D

export (String, FILE) var nextScene;
onready var player = Globals.player;

func _process(delta):
	if get_parent().doorOpened:
		if !player.canInteract and overlaps_body(player):
			player.canInteract = true;
		if player.canInteract and !overlaps_body(player):
			player.canInteract = false;
		if player.canInteract and overlaps_body(player):
			if Input.is_action_just_released("ui_select"):
				TransitionsAl.new_scene_dir = nextScene;
				TransitionsAl.load_state();	
