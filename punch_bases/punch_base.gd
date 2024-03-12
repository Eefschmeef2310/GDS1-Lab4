extends Node
#class_name
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
@onready var left_hitbox: CollisionShape2D = $"../../Body/LArm/LHand/LHitbox/CollisionShape2D"
@onready var right_hitbox: CollisionShape2D = $"../../Body/RArm/RHand/RHitbox/CollisionShape2D"
#Other Variables (please try to separate and organise!)
var can_punch: bool = true
var can_retract: bool = false
var is_right_arm: bool = true
var current_arm_anim: AnimationPlayer
#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	if can_punch && Input.is_action_pressed("Punch"):
		punch(is_right_arm)
	
	if(can_retract && !Input.is_action_pressed("Punch")):
		retract()
		
#endregion

#region Signal methods
func _on_left_hitbox_body_entered(body):
	if(body.is_in_group("Enemy")):
		#Functionality not added yet in other classes
		enemy_punched.emit()
	if(body.is_in_group("Player")):
		#Functionality not added yet in other classes
		player_punched.emit()
	pass # Replace with function body.
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
	is_right_arm = !is_right_arm
	can_punch = true
#endregion


