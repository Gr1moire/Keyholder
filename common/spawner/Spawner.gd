extends Node2D

signal stop
signal start
signal spawn

# Declare member variables here. Examples:
export(PackedScene) var enemy_preloaded = preload("res://enemies/enemy/enemy.tscn")
export(NodePath)    var parent_path: NodePath
export(float)       var interval: float = 1
export(bool)        var spawning: bool = true
export(PackedScene)	var secondary_enemy = preload("res://enemies/enemy_strong/enemy.tscn")
export(bool)		var secondary_spawning: bool = false
export(int)			var spawn_interval:int = 4

var parent: Node
var timer: Timer
var spawn_tick:int = 0

onready var expload = preload("res://common/explode.tscn")

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
	var enemy

	if secondary_spawning and spawn_tick == spawn_interval:
		enemy = secondary_enemy.instance()
		spawn_tick = 0
	else:
		enemy = enemy_preloaded.instance()
		spawn_tick += 1

	enemy.add_to_group("generatedEnemy");
	enemy.position = self.position
	parent.add_child(enemy)
	emit_signal("spawn")
	#spawn particules
	var ex = expload.instance()
	ex.emitting = true
	ex.position = Vector2(0, 0)
	add_child(ex)
	
func start():
	if timer.is_stopped():
		timer.start()
		$Particles2D.emitting = true;
		$AnimationPlayer.play("Light appear");
		emit_signal("start")

func stop():
	timer.stop()
	$Particles2D.emitting = false;
	$AnimationPlayer.play_backwards("Light appear");
	emit_signal("stop")
