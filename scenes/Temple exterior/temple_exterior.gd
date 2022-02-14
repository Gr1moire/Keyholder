extends Node2D

onready var dialog = Dialogic.start("Intro");
export (String, FILE) var nextScene;

func _ready():
	dialog.connect("dialogic_signal", self, "end_scene");

func end_scene(s):
	TransitionsAl.select_transition = TransitionsAl.transition_type.Pixelation
	TransitionsAl.new_scene_dir = nextScene;
	TransitionsAl.load_state();	
	
func start_dialog():
	add_child(dialog);
	$World/Player.canMove = false;
