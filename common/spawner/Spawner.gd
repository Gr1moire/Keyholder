extends Node2D


# Declare member variables here. Examples:
const enemy_preloaded = preload("res://enemies/enemy/enemy.tscn")
export var interval: float = 1

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.name = self.name + "_timer"
	timer.set_one_shot(false)
	timer.set_wait_time(interval)
	if timer.connect("timeout", self, "spawn"):
		print("error connecting")
	self.add_child(timer)
	timer.start()

func spawn():
	var enemy = enemy_preloaded.instance()
	enemy.position = self.position
	self.get_tree().get_root().add_child(enemy)
