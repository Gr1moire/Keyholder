extends "res://common/smooth_movement.gd"

# Declare member variables here. Examples:
var attached_to: Node2D = null
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

## Called when the node enters the scene tree for the first time.
func _ready():
	max_energy = $Light2D.energy
	Globals.key = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attached_to):
		self.move(attached_to.position, delta * 2.3)
	time += delta;
	var current_energy = clamp((health / max_health) * max_energy, 0, max_energy);
	var fluctuation_state = fluctuations.interpolate(health / max_health)
	var random_fluctuation = (noise.get_noise_1d(time * max_fluctuation_speed * fluctuation_state)
		* current_energy)
	$Light2D.energy = current_energy - random_fluctuation

func _physics_process(delta):
	if not attached_to or not attached_to.is_in_group("Player"):
		health -= 1 * delta * hp_drain_per_second
	else:
		health += 1 * delta * hp_heal_per_second
	health = clamp(health, 0, max_health)

func transfer_ownership(body: Node2D):
	attached_to = body
	body.has_key = true

func _on_RigidBody2D_body_entered(body: Node2D):
	for group in group_to_attach_to:
		if body.is_in_group(group):
			self.transfer_ownership(body)
			self.move(attached_to.position)
