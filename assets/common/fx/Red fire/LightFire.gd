extends Node2D

export (NodePath) var PlayerNode
onready var player = get_node(PlayerNode)
signal fireLit

var error = false
var isLit = false

func _input(event):
	lightFire(event)

func lightFire(event):
	if player:
		if $Detection.overlaps_area(player.get_child(5)) && !isLit: 
			if Input.is_action_just_pressed("ui_accept"):
				$AnimatedSprite.visible = true
				$Sprite.visible = false
				$AnimatedSprite/LitEffect.emitting = true
				$AnimatedSprite/LightingFire.play()
				$AnimatedSprite/ConstantNoise.play()
				$AnimatedSprite/Smoke.emitting = true
				isLit = true
				emit_signal("fireLit")

	elif !error:
		print ("PlayerNode not found in" + self.name)
		error = true
