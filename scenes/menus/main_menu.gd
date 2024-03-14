extends Control
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants
const OPTIONS = preload("res://scenes/menus/options.tscn")

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var change_username_button : Button

	#Onready Variables

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Set visibility of exit button (button not required for web)
	$MarginContainer/HBoxContainer/VBoxContainer/Exit.visible = OS.get_name() != "Web"
	change_username_button.text = "Change Username: " + AirtableManager.saveRes.username

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods
func _on_versus_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/versus.tscn")

func _on_training_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/training.tscn")

func _on_options_pressed():
	get_tree().root.add_child(OPTIONS.instantiate())
	
func _on_exit_pressed():
	get_tree().quit()
func _on_logout_pressed():
	get_tree().change_scene_to_file(AirtableManager.usernamePickerScene)
func _on_change_username_pressed():
	#print("haii")
	get_tree().change_scene_to_file(AirtableManager.usernameChangerScene)
#endregion

#region Other methods (please try to separate and organise!)

#endregion






