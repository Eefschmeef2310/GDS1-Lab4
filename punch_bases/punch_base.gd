extends Node
class_name PunchScript
#Authored by Alex. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal enemy_punched
signal player_punched
#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var left_hitbox: CollisionShape2D = $"../../Body/LArm/LHand/LeftHitbox/CollisionShape2D"
@onready var right_hitbox: CollisionShape2D = $"../../Body/RArm/RHand/RightHitbox/CollisionShape2D"

#Other Variables (please try to separate and organise!)
var can_punch: bool = true
var can_retract: bool = false
var is_right_arm: bool = true
var current_arm_anim: AnimationPlayer

var input_punch: bool = false #This variable determines the "input" from character
#endregion

#region Godot methods
func _physics_process(delta):
	#Runs per frame
	if can_punch && input_punch:
		punch(is_right_arm)
	
	if(can_retract && !input_punch):
		retract()
		
#endregion

#region Signal methods
func _on_punch_hitbox_body_entered(body):
	#Functionality not added yet in other classes
	#Should add score and knockback
	owner.hit.emit()

#endregion

#region Other methods (please try to separate and organise!)
func punch(right: bool):
	current_arm_anim = $"../../AnimationPlayers/RightArm" if right else $"../../AnimationPlayers/LeftArm"
	current_arm_anim.play("punch")
	can_punch = false
	
func finished_r_punch():
	right_hitbox.disabled = false
	await get_tree().create_timer(0.1).timeout
	right_hitbox.disabled = true
	can_retract = true

func finished_l_punch():
	left_hitbox.disabled = false
	await get_tree().create_timer(0.1).timeout
	left_hitbox.disabled = true
	can_retract = true

func retract():
	current_arm_anim.play("retract")
	right_hitbox.disabled = true 
	left_hitbox.disabled = true
	can_retract = false
	
func finished_retract():
	is_right_arm = !is_right_arm #For now used to alternate between left and right punches
	can_punch = true

#endregion


