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

#endregion

#region Godot methods
func _ready():
	visible = false
#endregion

#region Signal methods
func _on_game_end(b_score:int, r_score:int, time:int):
	if b_score > r_score:
		$ColorRect/MarginContainer/VBoxContainer/Winner.text  = "Blue wins!"
		$ColorRect/MarginContainer/VBoxContainer/Winner.set("theme_override_colors/font_color", Color(0, 0.251, 0.863))
	else:
		$ColorRect/MarginContainer/VBoxContainer/Winner.text  = "Red wins!"
		$ColorRect/MarginContainer/VBoxContainer/Winner.set("theme_override_colors/font_color", Color(0.8, 0, 0))
	$ColorRect/MarginContainer/VBoxContainer/HBoxScore/Value.text = str(b_score) + " - " + str(r_score)
	$ColorRect/MarginContainer/VBoxContainer/HBoxTime/Value.text = get_timer_string_from_seconds(time)
	visible = true
	get_tree().paused = true

func _on_menu_btn_pressed():
	get_tree().paused = false
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
#endregion


func _on_continue_button_pressed():
	continue_pressed.emit()
