extends WorldEnvironment

var introDone = false

func _ready():
	Music.playLevelSound();
	$"clé".connect("zero_health", self, "_start_lose_animation");
	$AnimationPlayer.connect("animation_finished", self, "_on_door_appeared");
	$"Intro Event".connect("body_entered", self, "_start_intro_animation");	
	$AnimationPlayer.play("Door Appear");

func _on_door_appeared(animName):
	if (animName == "Door Appear"):
		$Door2/Light2D2.enabled = true
		$AnimationPlayer.play("Light Appears")
		
func _start_lose_animation():
	$AnimationPlayer/LoseTween.loseAnimation();
	yield(get_tree().create_timer(2.0), "timeout");
	$"clé".start_key_lose_animation();

func _start_intro_animation(body):
	if (body == $Obstacles/YSort/Player and not introDone):
		introDone = true;
		$AnimationPlayer/IntroTween.introAnimation();
		yield(get_tree().create_timer(0.8), "timeout");
		$UI/Camera2D.current = true;
		Music.playLevelMusic();
		$Spawner.start();
		$Spawner2.start();
