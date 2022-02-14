extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var revelation_interval: float = 1
export(float) var blackout: float = 1
export(PackedScene) var scene_to_load: PackedScene
var can_cancel: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.start()

func start():
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/BigTitle.visible = true
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/Creator.visible = true
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/Patron.visible = true
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.visible = true
	$Node2D/FullTextRight.visible = true
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.set_max_lines_visible(2)
	$Node2D/FullTextRight.set_max_lines_visible(2)
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.set_max_lines_visible(3)
	$Node2D/FullTextRight.set_max_lines_visible(3)
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/Chapipi.visible = true
	self.can_cancel = true

func exit():
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/BigTitle.visible = false
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/Creator.visible = false
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/Patron.visible = false
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.set_max_lines_visible(2)
	$Node2D/FullTextRight.set_max_lines_visible(2)
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.set_max_lines_visible(1)
	$Node2D/FullTextRight.set_max_lines_visible(1)
	yield(self.get_tree().create_timer(revelation_interval), "timeout")
	$Node2D/FullTextLeft.visible = false
	$Node2D/FullTextRight.visible = false
	$Node2D/Chapipi.visible = false
	yield(self.get_tree().create_timer(revelation_interval + blackout), "timeout")
	if self.get_tree().change_scene_to(scene_to_load):
		print("error changing scene")
		self.get_tree().quit(1)

func _process(_delta):
	if self.can_cancel:
		if Input.is_action_pressed("ui_cancel"):
			self.can_cancel = false
			self.exit()
		
