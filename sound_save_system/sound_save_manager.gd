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
		
	#Set volumes
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), saved_settings.master)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), saved_settings.music)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), saved_settings.sfx)
#endregion

#region Other methods (please try to separate and organise!)
func save():
	ResourceSaver.save(saved_settings, save_path)
	
func load_save():
	saved_settings = ResourceLoader.load(save_path)
#endregion
