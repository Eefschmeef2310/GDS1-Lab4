extends Node
class_name MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Exported Variables
@export_group("Parameters")
@export var speed: float = 100

#Other Variables (please try to separate and organise!)
var direction:Vector2
#endregion

#region Godot methods
func _physics_process(_delta):
	owner.velocity = direction * speed
	owner.move_and_slide()
#endregion

#region Other methods
func set_direction(dir: Vector2):
	direction = dir
#end region
