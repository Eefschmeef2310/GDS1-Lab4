extends CanvasLayer
#class_name
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

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

func _process(delta):
	#Runs per frame
	pass
	
	

#endregion

#region Signal methods
func _on_game_end(b_score:int, r_score:int, time:int):
	$ColorRect/MarginContainer/VBoxContainer/Winner.text = "Blue wins" if b_score > r_score else "Red Wins"
	$ColorRect/MarginContainer/VBoxContainer/FinalScore.text = "Final Score = " + str(b_score) + " - " + str(r_score)
	$ColorRect/MarginContainer/VBoxContainer/TimeTaken.text = "Time Taken = " + get_timer_string_from_seconds(120 - time)
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
