extends Node2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal score_changed(blue_score: int, red_score: int)

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables

#Other Variables (please try to separate and organise!)
var blue_score: int = 0
var red_score: int = 0

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

func _on_blue_player_hit():
	red_score += 1
	score_changed.emit(blue_score, red_score)

func _on_red_player_hit():
	blue_score += 1
	score_changed.emit(blue_score, red_score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

#endregion

#region Other methods (please try to separate and organise!)

#endregion



