extends CanvasLayer
#Authored by Ethan. Please consult for any modifications or major feature requests.

@onready var blue_score = $BlueScore
@onready var red_score = $RedScore

func _process(delta):
	blue_score.scale = blue_score.scale.move_toward(Vector2(1, 1), 5*delta)
	red_score.scale = red_score.scale.move_toward(Vector2(1, 1), 5*delta)

#region Signal methods
func _on_gamemode_score_changed(b_score, r_score):
	var cblue = int(blue_score.text)
	var cred = int(red_score.text)
	
	blue_score.text = str(b_score)
	if b_score > cblue:
		blue_score.scale = Vector2(1.5, 1.5)
	
	red_score.text = str(r_score)
	if r_score > cred:
		red_score.scale = Vector2(1.5, 1.5)
	

func _on_gamemode_timer_changed(seconds):
	$Timer.text = get_timer_string_from_seconds(seconds)
	
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
	blue_score.add_theme_color_override("font_color", col)
	blue_score.add_theme_color_override("font_shadow_color", glow_col)

func set_red_data(data: FighterData, use_alternate := false):
	var col = data.battle_color if !use_alternate else data.alt_battle_color
	if col.srgb_to_linear().get_luminance() < 0.1:
		col = col.lightened(0.25)
	var glow_col = col
	glow_col.a = 0.5
	red_score.add_theme_color_override("font_color", col)
	red_score.add_theme_color_override("font_shadow_color", glow_col)

#endregion
