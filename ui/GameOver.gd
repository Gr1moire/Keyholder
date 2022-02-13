extends Control

export(String, FILE) var replayscene

func _ready():
	$MenuButton.visible = false
	$TitreFin.visible_characters = 0
	$AnimationPlayer.play("Pop")

func _on_RetourMenu_pressed():
	$ValidationSound.play()
	yield(get_tree().create_timer(1.0), "timeout")
	TransitionsAl.new_scene_dir = "res://menus/Menu.tscn"
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func _on_Rejouer_pressed():
	$ValidationSound.play()
	yield(get_tree().create_timer(1.0), "timeout")
	TransitionsAl.new_scene_dir = replayscene
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func fadding_letter_finished():
	$MenuButton.visible = true
	$MenuButton/Rejouer.grab_focus()


func _on_Rejouer_focus_entered():
	$ChangingSound.play()

func _on_RetourMenu_focus_entered():
	$ChangingSound.play()
