extends "res://common/smooth_movement.gd"

# Declare member variables here. Examples:
var attached_to: WeakRef
onready var noise = OpenSimplexNoise.new()
export(Array, String) var group_to_attach_to = ["Player"]
export(float) var max_health = 300.0;
export(float) var hp_drain_per_second = 10.0;
export(float) var hp_heal_per_second = 0.0;
export(Curve) var fluctuations;
export(float) var max_fluctuation_speed = 100.0;
export(float) var fluctuation_percentage = 30.0;
var max_time = 100000000.0
var time = 0.0;
var max_energy = 0;
var tmp
var health = max_health;
var lose:bool = false;
signal value_changed;
signal zero_health;

## Called when the node enters the scene tree for the first time.
func _ready():
	max_energy = $Light2D.energy
	Globals.key = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attached_to and attached_to.get_ref() and !lose):
		self.move(attached_to.get_ref().position, delta * 2.3)
	time += delta;
	var current_energy = clamp((health / max_health) * max_energy, 0, max_energy);
	var fluctuation_state = fluctuations.interpolate(health / max_health)
	var random_fluctuation = (noise.get_noise_1d(time * max_fluctuation_speed * fluctuation_state)
		* (current_energy * fluctuation_percentage / 100))
	$Light2D.color = Color($Light2D.color.r, $Light2D.color.g, $Light2D.color.b, current_energy + random_fluctuation)

func _physics_process(delta):
	if health <= 0 && !lose:
		lose = true;
		emit_signal("zero_health");
		pass
	if not lose and (!attached_to or !attached_to.get_ref() or not attached_to.get_ref().is_in_group("Player")):
		health -= 1 * delta * hp_drain_per_second
		emit_signal("value_changed");
	elif not lose:
		health += 1 * delta * hp_heal_per_second
		emit_signal("value_changed");
	health = clamp(health, 0, max_health)


func transfer_ownership(body: Node2D):
	attached_to = weakref(body)
	body.has_key = true

func _on_RigidBody2D_body_entered(body: Node2D):
	for group in group_to_attach_to:
		if body.is_in_group(group) and (!attached_to or !attached_to.get_ref()):
			self.transfer_ownership(body)
			self.move(attached_to.get_ref().position)
				
func start_key_lose_animation():
	$AnimationPlayer.play("Lose animation");
