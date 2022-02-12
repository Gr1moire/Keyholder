extends WorldEnvironment

export(Resource) var scene

func _ready():
	starting_state()
	$Timer.start(1)
	$Timer.connect("timeout", self, "pillarone")

func starting_state():
	$MenuMusic.play()
	$Pillar/Pillar_1/CastlePilarRight/AnimatedSprite.visible = false
	$Pillar/Pillar_1/CastlePilarLeft/AnimatedSprite.visible = false
	$Pillar/Pillar_2/CastlePilarRight/AnimatedSprite.visible = false
	$Pillar/Pillar_2/CastlePilarLeft/AnimatedSprite.visible = false
	$Pillar/Pillar_3/CastlePilarRight/AnimatedSprite.visible = false
	$Pillar/Pillar_3/CastlePilarLeft/AnimatedSprite.visible = false
	$Pillar/Pillar_1/CastlePilarLeft/Light2D.visible = false
	$Pillar/Pillar_1/CastlePilarRight/Light2D.visible = false
	$Pillar/Pillar_2/CastlePilarLeft/Light2D.visible = false
	$Pillar/Pillar_2/CastlePilarRight/Light2D.visible = false
	$Pillar/Pillar_3/CastlePilarLeft/Light2D.visible = false
	$Pillar/Pillar_3/CastlePilarRight/Light2D.visible = false
	$Pillar/Pillar_1/CastlePilarLeft/Particles2D.visible = false
	$Pillar/Pillar_1/CastlePilarRight/Particles2D.visible = false
	$Pillar/Pillar_2/CastlePilarLeft/Particles2D.visible = false
	$Pillar/Pillar_2/CastlePilarRight/Particles2D.visible = false
	$Pillar/Pillar_3/CastlePilarLeft/Particles2D.visible = false
	$Pillar/Pillar_3/CastlePilarRight/Particles2D.visible = false
	$Control/Title.visible_characters = 0
	$Control/MenuButton.visible = false
	$Door.visible = true

func pillarone():
	$Timer.disconnect("timeout", self, "pillarone")
	$Pillar/Pillar_1/CastlePilarLeft/AnimatedSprite.visible = true
	$Pillar/Pillar_1/CastlePilarRight/AnimatedSprite.visible = true
	$Pillar/Pillar_1/CastlePilarLeft/Light2D.visible = true
	$Pillar/Pillar_1/CastlePilarRight/Light2D.visible = true
	$Pillar/Pillar_1/CastlePilarLeft/Particles2D.visible = true
	$Pillar/Pillar_1/CastlePilarRight/Particles2D.visible = true
	$Timer.start(1)
	$Timer.connect("timeout", self, "pillartwo")

func pillartwo():
	$Timer.disconnect("timeout", self, "pillartwo")
	$Pillar/Pillar_2/CastlePilarLeft/AnimatedSprite.visible = true
	$Pillar/Pillar_2/CastlePilarRight/AnimatedSprite.visible = true
	$Pillar/Pillar_2/CastlePilarLeft/Light2D.visible = true
	$Pillar/Pillar_2/CastlePilarRight/Light2D.visible = true
	$Pillar/Pillar_2/CastlePilarLeft/Particles2D.visible = true
	$Pillar/Pillar_2/CastlePilarRight/Particles2D.visible = true
	$Timer.start(1)
	$Timer.connect("timeout", self, "pillarthree")

func pillarthree():
	$Timer.disconnect("timeout", self, "pillarthree")
	$Pillar/Pillar_3/CastlePilarLeft/AnimatedSprite.visible = true
	$Pillar/Pillar_3/CastlePilarRight/AnimatedSprite.visible = true
	$Pillar/Pillar_3/CastlePilarLeft/Light2D.visible = true
	$Pillar/Pillar_3/CastlePilarRight/Light2D.visible = true
	$Pillar/Pillar_3/CastlePilarLeft/Particles2D.visible = true
	$Pillar/Pillar_3/CastlePilarRight/Particles2D.visible = true
	$AnimationPlayer.play("Pop")

func fading_letter_finished():
	$Control/MenuButton.visible = true
	$Door.visible = false
	$Control/MenuButton/Start.grab_focus()

func _on_Start_pressed():
	$MenuMusic.stop()
	TransitionsAl.new_scene_dir = scene
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_focus_entered():
	$MenuSound.play()


func _on_Quit_focus_entered():
	$MenuSound.play()

