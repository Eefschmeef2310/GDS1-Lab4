extends CanvasLayer
#Authored by Ethan. Please consult for any modifications or major feature requests.

const CREDITS = preload("res://scenes/menus/credits.tscn")

#region Signal methods
func _on_back_button_pressed():
	SoundSaveManager.save()
	queue_free()
	
func _on_credits_button_pressed():
	get_tree().root.add_child(CREDITS.instantiate())
#endregion
