extends Node
class_name MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
@export var target: CharacterBody2D

@export_group("Parameters")
@export var speed: float = 100

#Onready Variables

#Other Variables (please try to separate and organise!)
var direction:Vector2

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	direction = Input.get_vector("Left", "Right", "Up", "Down");

func _physics_process(delta):
	target.velocity = direction * speed
	target.move_and_slide()
#endregion
