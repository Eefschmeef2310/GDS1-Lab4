extends MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Godot methods
func _process(_delta):
	#Set direction based on movement input
	set_direction(Input.get_vector("Left", "Right", "Up", "Down"))
	
	super._process(_delta)
#endregion
