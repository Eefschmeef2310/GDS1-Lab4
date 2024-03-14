extends Node
class_name MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.
#This script is the base for all movement scripts. It handles move_and_slide (direction calc logic is different
#between child scripts)

#region Variables
	#Exported Variables
@export_group("Parameters")


	#Other Variables (please try to separate and organise!)
var direction: Vector2
var knockback_velocity: float

var can_input: bool = true
#endregion

#region Godot methods
func _physics_process(_delta):
	if(can_input):
		owner.velocity = direction * owner.movement_speed
	else:
		var ko_direction = -1 if owner.rotation == 0 else 1
		owner.velocity = Vector2(ko_direction, 0) * knockback_velocity
		knockback_velocity = lerp(knockback_velocity, 0.0, 0.2*Engine.time_scale)
	owner.move_and_slide()

func _on_character_hit(knockback_power):
	can_input = false
	knockback_velocity = knockback_power
	await get_tree().create_timer(0.5).timeout
	can_input = true
#endregion

#region Other methods
func set_direction(dir: Vector2):
	direction = dir
#end region
