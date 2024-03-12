extends Node
#class_name
#Authored by [Name]. Please consult for any modifications or major feature requests.

#region Variables
#Signals

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
#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	if can_punch && Input.is_action_pressed("Punch"):
		punch()
	
	if(can_retract && !Input.is_action_pressed("Punch")):
		retract_r()
		
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func punch():
	$"../../AnimationPlayers/RightArm".play("punch")
	can_punch = false
	
func finished_r_punch():
	right_hitbox.disabled = false
	await get_tree().create_timer(0.1).timeout
	right_hitbox.disabled = true
	can_retract = true

	
func retract_r():
	$"../../AnimationPlayers/RightArm".play("retract")
	right_hitbox.disabled = true
	can_retract = false
	
func finished_retract():
	can_punch = true
#endregion

