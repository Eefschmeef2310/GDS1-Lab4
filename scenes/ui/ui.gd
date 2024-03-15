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

func set_blue_data(data: FighterData, use_alternate := false):
	var col = data.battle_color if !use_alternate else data.alt_battle_color
	if col.srgb_to_linear().get_luminance() < 0.1:
		col = col.lightened(0.25)
	var glow_col = col
	glow_col.a = 0.5
	$"MarginContainer/HBoxContainer/Blue Score".add_theme_color_override("font_color", col)
	$"MarginContainer/HBoxContainer/Blue Score".add_theme_color_override("font_shadow_color", glow_col)

func set_red_data(data: FighterData, use_alternate := false):
	var col = data.battle_color if !use_alternate else data.alt_battle_color
	if col.srgb_to_linear().get_luminance() < 0.1:
		col = col.lightened(0.25)
	var glow_col = col
	glow_col.a = 0.5
	$"MarginContainer/HBoxContainer/Red Score".add_theme_color_override("font_color", col)
	$"MarginContainer/HBoxContainer/Red Score".add_theme_color_override("font_shadow_color", glow_col)

#endregion
