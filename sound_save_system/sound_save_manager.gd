extends Node
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Constants
const save_path : String = "user://soundsettings.tres"

	#Other Variables (please try to separate and organise!)
var saved_settings : SoundSettings
#endregion

#region Godot methods
func _enter_tree():
	process_mode = Node.PROCESS_MODE_ALWAYS
	if FileAccess.file_exists(save_path):
		load_save()
	else:
		saved_settings = SoundSettings.new()
#endregion

#region Other methods (please try to separate and organise!)
func save():
	ResourceSaver.save(saved_settings, save_path)
	
func load_save():
	saved_settings = ResourceLoader.load(save_path)
#endregion
