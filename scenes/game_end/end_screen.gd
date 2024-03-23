extends CanvasLayer
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
	#Signals
signal continue_pressed

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")

	#Onready Variables

	#Other Variables (please try to separate and organise!)
var is_championship := false
var blue_color = Color.BLUE
var red_color = Color.RED
var blue_name = "Blue"
var red_name = "Red"
	
#endregion

#region Godot methods
func _ready():
	visible = false
#endregion

#region Signal methods
func _on_game_end(b_score:int, r_score:int, time:int, c_score:int):
	if b_score > r_score:
		$ColorRect/MarginContainer/VBoxContainer/Winner.text  = blue_name + " wins!"
		$ColorRect/MarginContainer/VBoxContainer/Winner.set("theme_override_colors/font_color", blue_color)
	elif r_score > b_score:
		if is_championship:
			$ColorRect/MarginContainer/VBoxContainer/Winner.text  = "Game over!"
			$AudioStreamPlayer.play()
		else:
			$ColorRect/MarginContainer/VBoxContainer/Winner.text  = red_name + " wins!"
		$ColorRect/MarginContainer/VBoxContainer/Winner.set("theme_override_colors/font_color", red_color)
		$ColorRect/MarginContainer/VBoxContainer/ButtonContainer/ContinueButton.hide()
	else:
		if is_championship:
			$ColorRect/MarginContainer/VBoxContainer/Winner.text  = "Draw (Game over!)"
		else:
			$ColorRect/MarginContainer/VBoxContainer/Winner.text  = "Draw!"
		$ColorRect/MarginContainer/VBoxContainer/ButtonContainer/ContinueButton.hide()

	$ColorRect/MarginContainer/VBoxContainer/HBoxScore/Value.text = str(b_score) + " - " + str(r_score)
	$ColorRect/MarginContainer/VBoxContainer/HBoxTime/Value.text = get_timer_string_from_seconds(time)
	$ColorRect/MarginContainer/VBoxContainer/HBoxChamp/Value.text = str(c_score)
	
	visible = true
	get_tree().paused = true

func _on_menu_btn_pressed():
	get_tree().paused = false
	GlobalSteam.EndConnection.rpc()
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _on_versus_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gamemodes/versus.tscn")
#endregion


#region Other methods (please try to separate and organise!)

func get_timer_string_from_seconds(time_elapsed := 0.0):
	var minutes := time_elapsed / 60
	var seconds := fmod(time_elapsed, 60)
	var time_string := "%02d:%02d" % [minutes, seconds]
	return time_string

func set_player_data(blue: FighterData, red: FighterData, use_alternate := false):
	blue_name = blue.first_name
	red_name = red.first_name
	blue_color = blue.battle_color
	red_color = red.battle_color if !use_alternate else red.alt_battle_color

#endregion


func _on_continue_button_pressed():
	get_tree().paused = false
	continue_pressed.emit()

func set_championship():
	is_championship = true
	$ColorRect/MarginContainer/VBoxContainer/HBoxChamp.show()
	$ColorRect/MarginContainer/VBoxContainer/ButtonContainer/ContinueButton.show()
	$ColorRect/MarginContainer/VBoxContainer/ButtonContainer/OtherBtn.hide()
