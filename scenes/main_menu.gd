extends Control
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
	#Set visibility of exit button (button not required for web)
	$MarginContainer/HBoxContainer/VBoxContainer/Exit.visible = OS.get_name() != "Web"

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_exit_pressed():
	get_tree().quit()
#endregion

#region Other methods (please try to separate and organise!)

#endregion
