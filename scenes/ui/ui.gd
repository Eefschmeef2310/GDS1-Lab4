extends CanvasLayer
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

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
func score_changed():
	#Needs to be hooked up and done properly
	$"MarginContainer/HBoxContainer/Blue Score".text = "Blue score updated!"
	$"MarginContainer/HBoxContainer/Red Score".text = "Red score updated!"
#endregion

#region Other methods (please try to separate and organise!)

#endregion
