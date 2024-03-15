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
@onready var battle = $Battle

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	battle.base_level.get_blue_player().set_as_player("p1_")
	battle.base_level.get_red_player().set_as_player("p2_")
	
	var p1 = load("res://fighters/dummy.tres")
	var p2 = load("res://fighters/dummy.tres")
	
	battle.set_fighter_data(p1, "p1_", p2, "p2_")

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
