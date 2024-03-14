extends Node2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal score_changed(blue_score: int, red_score: int)
signal timer_changed(seconds: float)
signal game_ended(blue_score: int, red_score: int, timer:int, champ_score:int)
signal hide_ui()
signal continue_championship(new_score: int)

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var base_level: BaseLevel = $BaseLevel
@onready var match_timer = $MatchTimer
@onready var end_screen = $EndScreen

#Other Variables (please try to separate and organise!)
var blue_score: int = 0
var red_score: int = 0

var championship_score: int = 0

#endregion

#region Godot methods
func _ready():
	base_level.start_countdown()
	await base_level.countdown_complete
	match_timer.start()

func _process(_delta):
	#Runs per frame
	timer_changed.emit(match_timer.time_left)
#endregion

#region Signal methods

func _on_base_level_blue_player_hit():
	red_score += 1
	score_changed.emit(blue_score, red_score)
	check_game_end()

func _on_base_level_red_player_hit():
	blue_score += 1
	score_changed.emit(blue_score, red_score)
	check_game_end()

func _on_end_screen_continue_pressed():
	continue_championship.emit()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

#endregion

#region Other methods (please try to separate and organise!)

func check_game_end():
	if(blue_score == 3 || red_score == 3 || match_timer.time_left == 0):
		# Calculate new score
		if blue_score > red_score:
			var addition = max(0, blue_score - red_score) + floor(match_timer.time_left)
			championship_score += (addition * 100)
		
		base_level.start_slowmo()
		await base_level.slowmo_complete
		hide_ui.emit()
		game_ended.emit(blue_score, red_score, match_timer.time_left, championship_score)

#endregion