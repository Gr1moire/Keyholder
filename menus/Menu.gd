extends WorldEnvironment

export (String, FILE) var scene

func _ready():
	starting_state()
	$Timer.start(1)
	$Timer.connect("timeout", self, "pillarone")

func starting_state():
	$CanvasLayer/KeyQuit.visible = false
	$CanvasLayer/KeyStart.visible = false
	$Props/PiedestalLight.visible = false
	$Props/PiedestalLight2.visible = false
	$Props/PiedestalLight/Light2D.visible = false
	$Props/PiedestalLight/Light2D2.visible = false
	$Props/PiedestalLight/Light2D3.visible = false
	$Props/PiedestalLight/Light2D4.visible = false
	$Props/PiedestalLight2/Light2D.visible = false
	$Props/PiedestalLight2/Light2D2.visible = false
	$Props/PiedestalLight2/Light2D3.visible = false
	$Props/PiedestalLight2/Light2D4.visible = false
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
	$CanvasLayer/Control/Title.visible_characters = 0
	$CanvasLayer/Control/MenuButton.visible = false
	$Door.visible = true

func pillarone():
	$Timer.disconnect("timeout", self, "pillarone")
	$LightFireSound.play()
	$FireSound.play()
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
	$LightFireSound.play()
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
	$LightFireSound.play()
	$Pillar/Pillar_3/CastlePilarLeft/AnimatedSprite.visible = true
	$Pillar/Pillar_3/CastlePilarRight/AnimatedSprite.visible = true
	$Pillar/Pillar_3/CastlePilarLeft/Light2D.visible = true
	$Pillar/Pillar_3/CastlePilarRight/Light2D.visible = true
	$Pillar/Pillar_3/CastlePilarLeft/Particles2D.visible = true
	$Pillar/Pillar_3/CastlePilarRight/Particles2D.visible = true
	$Props/PiedestalLight.visible = true
	$Props/PiedestalLight2.visible = true
	$Props/PiedestalLight/Light2D.visible = true
	$Props/PiedestalLight/Light2D2.visible = true
	$Props/PiedestalLight/Light2D3.visible = true
	$Props/PiedestalLight/Light2D4.visible = true
	$Props/PiedestalLight2/Light2D.visible = true
	$Props/PiedestalLight2/Light2D2.visible = true
	$Props/PiedestalLight2/Light2D3.visible = true
	$Props/PiedestalLight2/Light2D4.visible = true
	$AnimationPlayer.play("Pop")
	$MenuMusic.play()

func fading_letter_finished():
	$CanvasLayer/Control/MenuButton.visible = true
	$Door.visible = false
	$CanvasLayer/Control/MenuButton/Start.grab_focus()

func _on_Start_pressed():
	$MenuMusic.stop()
	$FireSound.stop()
	TransitionsAl.new_scene_dir = scene
	TransitionsAl.select_transition = TransitionsAl.transition_type.Fade
	TransitionsAl.load_state()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_focus_entered():
	$MenuSound.play()
	$CanvasLayer/KeyStart.visible = true
	$CanvasLayer/KeyQuit.visible = false


func _on_Quit_focus_entered():
	$MenuSound.play()
	$CanvasLayer/KeyStart.visible = false
	$CanvasLayer/KeyQuit.visible = true

