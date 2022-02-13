extends WorldEnvironment

onready var timer = $Timer
export (float) var timeout = 300.0

func _ready():
	Music.play()
	$"clé".connect("zero_health", self, "_start_lose_animation");
	$AnimationPlayer.connect("animation_finished", self, "_on_door_appeared");
	$AnimationPlayer.play("Door Appear")

func _on_door_appeared(sceneName):
	if (sceneName == "Door Appear"):
		$Door2/Light2D2.enabled = true
		$AnimationPlayer.play("Light Appears")
		
func _start_lose_animation():
	$AnimationPlayer/LoseTween.loseAnimation();
	yield(get_tree().create_timer(2.0), "timeout");
	$"clé".start_key_lose_animation();
