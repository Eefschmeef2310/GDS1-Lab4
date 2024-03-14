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

func _process(delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_blue_player_hit(_knockback_power):
	red_score += 1
	score_changed.emit(blue_score, red_score)
	check_game_end()

func _on_red_player_hit(_knockback_power):
	blue_score += 1
	score_changed.emit(blue_score, red_score)
	check_game_end()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

#endregion

#region Other methods (please try to separate and organise!)

#endregion
