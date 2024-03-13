extends CanvasLayer
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Constants
const OPTIONS = preload("res://scenes/menus/options.tscn")
#endregion

#region Godot methods
func _ready():
	get_tree().paused = true
#endregion

#region Signal methods
func _on_continue_button_pressed():
	get_tree().paused = false
	queue_free()
	
func _on_options_button_pressed():
	get_tree().root.add_child(OPTIONS.instantiate())

func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	queue_free()
#endregion
