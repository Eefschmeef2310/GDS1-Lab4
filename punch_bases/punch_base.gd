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
@onready var left_anim: AnimationPlayer = $"../../AnimationPlayers/LeftArm"
@onready var right_anim: AnimationPlayer = $"../../AnimationPlayers/RightArm"
#Other Variables (please try to separate and organise!)
var punch_buffer: float = 0.2
var buffer_timer: float = 0

var frequency_timer: float = 0 # Prevent punch spam

var can_r_punch: bool = true
var can_l_punch: bool = true

var is_right_arm: bool = true
#endregion

#region Godot methods

func _ready():
	$"../../AnimationPlayers/RightArm".play("retract")
	$"../../AnimationPlayers/LeftArm".play("retract")
	left_hitbox.disabled = true
	right_hitbox.disabled = true

func _physics_process(_delta):
	#Runs per frame
	if can_punch() && buffer_timer > 0:
		punch(is_right_arm)
	
	buffer_timer -= _delta
	frequency_timer -= _delta
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func input_punch():
	buffer_timer = punch_buffer
	
func can_punch():
	return (can_l_punch || can_r_punch) && frequency_timer < 0


func punch(right: bool):
	#play punch sound
	if $"../../AudioPlayers/Punch" : $"../../AudioPlayers/Punch".play()
	
	buffer_timer = 0
	frequency_timer = owner.punch_frequency
	
	if(right):
		$"../../AnimationPlayers/RightArm".play("punch", -1, 1/owner.punch_speed_seconds)
		$"../../Body/RArm/RHand/RightHitbox/CollisionShape2D".disabled = false
		can_r_punch = false
	else:
		$"../../AnimationPlayers/LeftArm".play("punch", -1, 1/owner.punch_speed_seconds)
		$"../../Body/LArm/LHand/LeftHitbox/CollisionShape2D".disabled = false
		can_l_punch = false
		
	is_right_arm = !is_right_arm
	
func retract_r():
	$"../../AnimationPlayers/RightArm".play("retract", -1, 1/owner.retract_speed_seconds)
	$"../../Body/RArm/RHand/RightHitbox/CollisionShape2D".disabled = true 

func retract_l():
	$"../../AnimationPlayers/LeftArm".play("retract", -1, 1/owner.retract_speed_seconds)
	$"../../Body/LArm/LHand/LeftHitbox/CollisionShape2D".disabled = true 

func finished_r_retract():
	can_r_punch = true
	
func finished_l_retract():
	can_l_punch = true
#endregion


