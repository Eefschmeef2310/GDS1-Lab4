extends Node
class_name AiScript
#Authored by AlexV. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums
enum States {
	Pressure, #Try to stay within a short range of the other player (almost within reach)
	Attack, #Go in and attack the player
	Retreat #Bitch out of attacking range (Usually right after attacking)
}
	#Constants

	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")

	#Onready Variables
@onready var movement_script: MovementScript = $"../Movement"
@onready var punch_script: PunchScript = $"../Punches"
	#Other Variables (please try to separate and organise!)

var other_player: Player

var current_state: States = States.Pressure
var current_direction: Vector2
var tick_max: float = 0.5
var tick_timer: float = 0
#endregion

#region Godot methods
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player != owner:
			other_player = player
			return

func _process(_delta):
	#After every "Tick", update the direction and/or state of the player
	if(tick_timer < 0):
		var pos_aim = other_player.global_position + (Vector2(200, 0) if owner.rotation == deg_to_rad(180) else Vector2(-200, 0))
		current_direction = pos_aim - owner.global_position
		tick_timer = tick_max
	
	move(current_direction.normalized())
	
	tick_timer -= _delta
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)
func punch():
	punch_script.input_punch()
	pass

func move(dir: Vector2):
	movement_script.move_in_direction(dir)
#endregion

