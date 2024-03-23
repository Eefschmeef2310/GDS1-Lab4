

extends Node2D
class_name Battle
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
@onready var ui = $Ui

#Other Variables (please try to separate and organise!)
@export var blue_score: int = 0
@export var red_score: int = 0

var game_over := false

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
	blueHit.rpc()

@rpc("any_peer", "call_local")
func blueHit():
	if !game_over:
		red_score += 1
		score_changed.emit(blue_score, red_score)
		check_game_end()

func _on_base_level_red_player_hit():
	redHit.rpc()

@rpc("any_peer", "call_local")
func redHit():
	if !game_over:
		blue_score += 1
		score_changed.emit(blue_score, red_score)
		check_game_end()

func _on_end_screen_continue_pressed():
	continue_championship.emit(championship_score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

#endregion

#region Other methods (please try to separate and organise!)

func check_game_end():
	if(blue_score == 21 || red_score == 21 || match_timer.time_left == 0):
		# Calculate new score
		if blue_score > red_score:
			var addition = max(0, blue_score - red_score) + floor(match_timer.time_left)
			championship_score += (addition * 100)
		
		game_over = true
		base_level.start_slowmo()
		await base_level.slowmo_complete
		hide_ui.emit()
		game_ended.emit(blue_score, red_score, match_timer.time_left, championship_score)
		

func set_fighter_data(blue: FighterData, blue_type: String, red: FighterData, red_type: String):
	match blue_type:
		"ai":
			base_level.get_blue_player().set_as_ai()
		"dummy":
			base_level.get_blue_player().set_as_dummy()
		_:
			base_level.get_blue_player().set_as_player(blue_type)
	match red_type:
		"ai":
			base_level.get_red_player().set_as_ai()
		"dummy":
			base_level.get_red_player().set_as_dummy()
		_:
			base_level.get_red_player().set_as_player(red_type)
	var is_ditto = blue == red
	base_level.get_blue_player().load_resource(blue)
	base_level.get_red_player().load_resource(red, is_ditto)
	base_level.set_player_data(blue, red, is_ditto)
	ui.set_blue_data(blue)
	ui.set_red_data(red, is_ditto)
	end_screen.set_player_data(blue, red, is_ditto)

#endregion
