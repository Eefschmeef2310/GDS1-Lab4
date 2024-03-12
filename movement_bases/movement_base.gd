extends Node
class_name MovementScript
#Authored by Ethan. Please consult for any modifications or major feature requests.
#This script is the base for all movement scripts. It handles move_and_slide (direction calc logic is different
#between child scripts) and auto-rotation. Used by training dummy

#region Variables
	#Exported Variables
@export_group("Parameters")
@export var speed: float = 100

	#Other Variables (please try to separate and organise!)
var direction:Vector2

var other_player : Node2D
#endregion

#region Godot methods
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player != owner:
			other_player = player
			return

func _process(_delta):
	if other_player:
		owner.rotation = deg_to_rad(180) if other_player.global_position.x < owner.global_position.x else 0

func _physics_process(_delta):
	owner.velocity = direction * speed
	owner.move_and_slide()
#endregion

#region Other methods
func set_direction(dir: Vector2):
	direction = dir
#end region
