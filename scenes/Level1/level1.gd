extends WorldEnvironment

onready var timer = $Timer
export (float) var timeout = 300.0

func _ready():
	timer.wait_time = timeout
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timeout")	
	timer.start()
	$AnimationPlayer.play("Door Appear")

func _on_timeout():
	$Door2/Light2D2.enabled = true
	$AnimationPlayer.play("Light Appears")
