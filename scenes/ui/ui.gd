extends CanvasLayer
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")

	#Onready Variables
@onready var match_timer: Timer = $"../MatchTimer"

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	# Update timer
	$MarginContainer/HBoxContainer/Timer.text = get_timer_string_from_seconds(match_timer.time_left)
	
#endregion

#region Signal methods
func _on_versus_score_changed(blue_score, red_score):
	$"MarginContainer/HBoxContainer/Blue Score".text = str(blue_score)
	$"MarginContainer/HBoxContainer/Red Score".text = str(red_score)
#endregion

#region Other methods (please try to separate and organise!)

func get_timer_string_from_seconds(time_elapsed := 0.0):
	var minutes := time_elapsed / 60
	var seconds := fmod(time_elapsed, 60)
	var time_string := "%02d:%02d" % [minutes, seconds]
	return time_string

#endregion
