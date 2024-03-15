extends Control

func _on_button_pressed():
	#queue_free()
	get_tree().change_scene_to_file(AirtableManager.menuSceme)
