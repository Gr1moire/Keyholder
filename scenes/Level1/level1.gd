extends WorldEnvironment

var introDone = false;
var doorOpened = false;

func _ready():
	Music.playLevelSound();
	$"clé".connect("zero_health", self, "_start_lose_animation");
	$DoorAnim.connect("animation_finished", self, "_on_door_appeared");
	if (get_tree().get_current_scene().get_name() == "Level1"):
		$"Intro Event".connect("body_entered", self, "_start_intro_animation");	
	if (get_tree().current_scene.name != "Level1"):
		print("bjr");
		$DoorAnim.play("Door Appear");
	if (get_tree().current_scene.name == "Level3"):
		$SpawnAnim.play("spawn");

func _on_door_appeared(animName):
	if (animName == "Door Appear"):
		$Door2/Rumble.play();
		$Door2/Light2D2.enabled = true;
		$Door2.turn_light_on();
		doorOpened = true;
		
func _start_lose_animation():
	$DoorAnim/LoseTween.loseAnimation();
	yield(get_tree().create_timer(1.0), "timeout");
	$"clé".start_key_lose_animation();
	yield(get_tree().create_timer(2.0), "timeout");
	$UI/Label/GameOver.pop();
	
func _start_intro_animation(body):
	if (body == $Obstacles/YSort/Player and not introDone):
		introDone = true;
		$DoorAnim/IntroTween.introAnimation();
		yield(get_tree().create_timer(0.8), "timeout");
		$UI/Camera2D.current = true;
		if (!Music.getIsLevelMusicPlaying()):
			Music.playLevelMusic();
		$Spawner.start();
		$Spawner2.start();
		$DoorAnim.play("Door Appear");	
