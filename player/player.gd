extends CharacterBody2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal hit()

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Debug for knockback
	if(Input.is_action_just_pressed("p2_down")): 
		hit.emit()
	pass
#endregion

#region Signal methods

func _on_head_hurtbox_area_entered(area):
	print("Punchout!!!")
	hit.emit()

#endregion

#region Other methods (please try to separate and organise!)

#endregion
