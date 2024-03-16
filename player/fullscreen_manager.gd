extends Node
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Godot methods
func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.WINDOW_MODE_MAXIMIZED else DisplayServer.WINDOW_MODE_MAXIMIZED)
#endregion
