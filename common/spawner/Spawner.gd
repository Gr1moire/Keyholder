extends Node2D

signal stop
signal start
signal spawn

# Declare member variables here. Examples:
export(PackedScene) var enemy_preloaded = preload("res://enemies/enemy/enemy.tscn")

export(NodePath)    var parent_path: NodePath
export(float)       var interval: float = 1
export(bool)        var spawning: bool = true

var parent: Node
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
	
	parent = self.get_node(parent_path)

	if !parent:
		parent = self.get_tree().get_root()

	if spawning:
		self.start()

func spawn():
	var enemy = enemy_preloaded.instance()
	enemy.add_to_group("generatedEnemy");
	enemy.position = self.position
	parent.add_child(enemy)
	emit_signal("spawn")

func start():
	if timer.is_stopped():
		timer.start()
		emit_signal("start")

func stop():
	timer.stop()
	emit_signal("stop")
