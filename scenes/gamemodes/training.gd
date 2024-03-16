extends Node2D
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
@onready var prematch_screen = $PrematchScreen
@onready var default_fighter = preload("res://fighters/jack.tres")
@onready var base_level_scene: PackedScene = preload("res://scenes/base_level.tscn")
@onready var base_level: BaseLevel = $BaseLevel

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	prematch_screen.set_character_select("Versus")
	
	base_level.get_blue_player().set_as_player("p1_")
	base_level.get_red_player().set_as_dummy()
	base_level.get_blue_player().load_resource(preload("res://fighters/jack.tres"))
	base_level.get_red_player().load_resource(preload("res://fighters/dummy.tres"))

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
#endregion

#region Other methods (please try to separate and organise!)

#endregion
