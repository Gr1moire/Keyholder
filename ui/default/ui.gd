extends ProgressBar

onready var key = get_node("../../../clé");
var bbcode_format = "[center] %d / %d [/center]"

func _ready():
	if (key):
		key.connect("value_changed", self, "update_value");
		max_value = key.max_health;
		value = key.health;
		$StaminaText.bbcode_text = bbcode_format % [int(key.health), key.max_health];
	else:
		print("Key not connected");

func update_value():
	value = key.health;
	$StaminaText.bbcode_text = bbcode_format % [int(key.health), key.max_health];	
