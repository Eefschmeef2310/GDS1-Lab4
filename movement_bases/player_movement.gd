extends MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.

@export var input_prefix: String = "p1_"

#region Godot methods
func _process(_delta):
	#Set direction based on movement input
	if !is_multiplayer_authority():
		return
	set_direction(Input.get_vector(input_prefix+"left", input_prefix+"right", input_prefix+"up", input_prefix+"down"))
	
	#super._process(_delta)
#endregion
