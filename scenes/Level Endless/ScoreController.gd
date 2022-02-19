extends Control

var score : int = 0
var format = "[center] %d [/center]"
export (int) var pointsPerSecond = 1
export (int) var pointsPerEnemyKilled = 1

func _ready():
	$Timer.connect("timeout", self, "_add_time_score");
	
func _add_time_score():
	score += pointsPerSecond;
	$ScoreValue.bbcode_text = format % [score]

func _add_enemy_killed_score():
	score += pointsPerEnemyKilled;
	$ScoreValue.bbcode_text = format % [score]	
