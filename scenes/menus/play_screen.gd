extends CanvasLayer
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Godot methods
func _ready():
	visibility_changed.connect(animate)
#endregion

#region Other methods (please try to separate and organise!)
func animate():
	if visible:
		$TextureAnimators.play("default")
#endregion
