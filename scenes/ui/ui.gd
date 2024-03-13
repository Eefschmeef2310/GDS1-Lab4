extends CanvasLayer
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Signal methods
func _on_gamemode_score_changed(blue_score, red_score):
	$"MarginContainer/HBoxContainer/Blue Score".text = str(blue_score)
	$"MarginContainer/HBoxContainer/Red Score".text = str(red_score)

func _on_gamemode_timer_changed(seconds):
	$MarginContainer/HBoxContainer/Timer.text = get_timer_string_from_seconds(seconds)
	
func _on_game_end():
	visible = false

#region Other methods (please try to separate and organise!)

func get_timer_string_from_seconds(time_elapsed := 0.0):
	var minutes := time_elapsed / 60
	var seconds := fmod(time_elapsed, 60)
	var time_string := "%02d:%02d" % [minutes, seconds]
	return time_string
	
#endregion
