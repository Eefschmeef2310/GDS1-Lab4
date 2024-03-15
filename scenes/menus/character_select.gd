extends VBoxContainer
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals

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
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_fighter_select_hover_fighter(data):
	owner.set_blue_data(data)

#endregion

#region Other methods (please try to separate and organise!)

#endregion
