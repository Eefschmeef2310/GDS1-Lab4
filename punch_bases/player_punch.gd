extends PunchScript
#class_name
#Authored by [Name]. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")
@export var input_prefix: String = "p1_"

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	super()

func _process(_delta):
	if Input.is_action_just_pressed(input_prefix+"punch") : input_punch()
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion

