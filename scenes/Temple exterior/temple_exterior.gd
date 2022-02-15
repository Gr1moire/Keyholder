extends Node2D

onready var dialog = Dialogic.start("Intro");
export (String, FILE) var nextScene;

func _ready():
	dialog.connect("dialogic_signal", self, "end_scene");
	starting_state();
	$Timer.start(1);
	$Timer.connect("timeout", self, "pop_title");
	$Control/MenuButton/Start.connect("pressed", self, "_on_Start_pressed");
	$Control/MenuButton/Quit.connect("pressed", self, "_on_Quit_pressed");
	$Control/MenuButton/Start.connect("focus_entered", self, "_on_Start_focus_entered");
	$Control/MenuButton/Quit.connect("focus_entered", self, "_on_Quit_focus_entered");
	
#Dialogs
func end_scene(s):
	TransitionsAl.select_transition = TransitionsAl.transition_type.Pixelation
	TransitionsAl.new_scene_dir = nextScene;
	TransitionsAl.load_state();	
	
func start_dialog():
	add_child(dialog);
	$World/Player.canMove = false;

#Menu
var selectionMade = false;

func starting_state():
	$Control/KeyQuit.visible = false
	$Control/KeyStart.visible = false
	$Control/Title.visible_characters = 0
	$Control/MenuButton.visible = false

func pop_title():
	$AnimationPlayer.play("Pop")
	$MenuMusic.play()

func fading_letter_finished():
	$Control/MenuButton.visible = true
	$Control/MenuButton/Start.grab_focus()

func _on_Start_pressed():
	if !selectionMade:
		selectionMade = true;				
		$MenuValidation.play()
		yield(get_tree().create_timer(1.0), "timeout")
		$AnimationPlayer.play("MenuFade");


func _on_Quit_pressed():
	if !selectionMade:
		selectionMade = true;		
		$MenuValidation.play()
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().quit()

func _on_Start_focus_entered():
	if !selectionMade:	
		$MenuSound.play()
		$Control/KeyStart.visible = true
		$Control/KeyQuit.visible = false


func _on_Quit_focus_entered():
	if !selectionMade:
		$MenuSound.play()
		$Control/KeyStart.visible = false
		$Control/KeyQuit.visible = true


