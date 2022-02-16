extends Node2D

export(int) var MAXLIFE: int = 1

var life:int

func _ready():
	life = MAXLIFE

func took_damage(damage):
	life -= damage
	if life < 0:
		life = 0
