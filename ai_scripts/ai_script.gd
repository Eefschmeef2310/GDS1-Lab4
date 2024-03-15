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
var tick_max: float = 0.3
var tick_timer: float = 0
#endregion

#region Godot methods
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player != owner:
			other_player = player
			return
			
	tick_max = owner.movement_speed * 1.5 / 100

func _process(_delta):
	#After every "Tick", update the direction and/or state of the player

	if(current_state == States.Pressure): pressure_state(_delta)
	elif(current_state == States.Attack): attack_state()
	else: retreat_state()
		

	move(current_direction.normalized())
	
	tick_timer -= _delta
#endregion

#region Signal methods
func _on_attacked_revenge(power: float):
	#current_state = States.Attack
	pass
#endregion

#region Other methods (please try to separate and organise!)
func pressure_state(_delta):
	if tick_timer > 0: return

	var pos_aim = other_player.global_position + (Vector2(-owner.movement_speed, 0) if owner.rotation == 0 else Vector2(owner.movement_speed, 0))
	current_direction = pos_aim - owner.global_position
	if(current_direction.length() < 50 && (randi() % 100 + 1) < 100*tick_max):
		current_state = States.Attack
	tick_timer = tick_max
	
func attack_state():
	#Go in and attack the player while you can still attack
	var punch_pos = Vector2(-100, -40)
	if(!punch_script.is_right_arm): punch_pos.y *= -1
	if(!owner.rotation == 0): punch_pos *= -1
	print(punch_pos)
	current_direction = other_player.global_position + punch_pos - owner.global_position
	
	if(current_direction.length() < 50 && punch_script.can_punch()):
		punch_script.input_punch()
	elif(!punch_script.can_punch()):
		current_state = States.Retreat
		tick_timer = tick_max
		
func retreat_state():
	if tick_timer > 0: return
	
	current_direction = owner.global_position - other_player.global_position
	if(punch_script.can_punch()):
		current_state = States.Pressure
	tick_timer = tick_max

func punch():
	punch_script.input_punch()

func move(dir: Vector2):
	movement_script.move_in_direction(dir)
#endregion

