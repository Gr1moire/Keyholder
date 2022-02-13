extends Control

export(String, FILE) var replayscene

func _ready():
	$MenuButton.visible = false
	$TitreFin.visible_characters = 0
	$AnimationPlayer.play("Pop")

func _on_RetourMenu_pressed():
	TransitionsAl.new_scene_dir = "res://menus/Menu.tscn"
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func _on_Rejouer_pressed():
	TransitionsAl.new_scene_dir = replayscene
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func fadding_letter_finished():
	$MenuButton.visible = true
	$MenuButton/Rejouer.grab_focus()
