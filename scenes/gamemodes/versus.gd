extends Node2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal score_changed(blue_score: int, red_score: int)
signal timer_changed(seconds: float)
signal game_ended(blue_score: int, red_score: int, timer:int)
signal hide_ui()

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var match_timer = $MatchTimer

#Other Variables (please try to separate and organise!)
var blue_score: int = 0
var red_score: int = 0

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(_delta):
	#Runs per frame
	timer_changed.emit(match_timer.time_left)
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
func check_game_end():
	if(blue_score == 1 || red_score == 1 || match_timer.time_left == 0):
		hide_ui.emit()
		game_ended.emit(blue_score, red_score, match_timer.time_left)
#endregion



