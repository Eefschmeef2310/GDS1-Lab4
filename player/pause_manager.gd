extends Node
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Constants
const PAUSE = preload("res://scenes/menus/pause.tscn")
#endregion

#region Godot methods
func _input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().root.add_child(PAUSE.instantiate())
#endregion
