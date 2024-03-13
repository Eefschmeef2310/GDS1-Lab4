extends Node
class_name PunchScript
#Authored by Alex. Please consult for any modifications or major feature requests.

#region Variables
#Signals

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

func _ready():
	$"../../AnimationPlayers/RightArm".play("retract")
	$"../../AnimationPlayers/LeftArm".play("retract")
	left_hitbox.disabled = true
	right_hitbox.disabled = true

func _physics_process(delta):
	#Runs per frame
	if can_punch && input_punch:
		punch(is_right_arm)
	
	if(can_retract && !input_punch):
		retract()
		
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func punch(right: bool):
	current_arm_anim = $"../../AnimationPlayers/RightArm" if right else $"../../AnimationPlayers/LeftArm"
	current_arm_anim.play("punch")
	
	left_hitbox.disabled = false
	right_hitbox.disabled = false
	
	can_punch = false
	
func finished_punch():
	can_retract = true
	left_hitbox.disabled = true
	right_hitbox.disabled = true

func retract():
	current_arm_anim.play("retract")
	right_hitbox.disabled = true 
	left_hitbox.disabled = true
	can_retract = false
	
func finished_retract():
	is_right_arm = !is_right_arm #For now used to alternate between left and right punches
	can_punch = true

#endregion


