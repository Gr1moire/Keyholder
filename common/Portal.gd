extends Area2D

export (String, FILE) var nextScene;
onready var door = get_node("../Door2");
onready var player = Globals.player;

func _process(delta):
	if get_parent().doorOpened:
		if !door.canInteract and overlaps_body(player):
			door.canInteract = true;
		if door.canInteract and !overlaps_body(player):
			door.canInteract = false;
			
		if door.canInteract and overlaps_body(player):
			if Input.is_action_just_released("ui_select"):
				TransitionsAl.new_scene_dir = nextScene;
				TransitionsAl.load_state();	
