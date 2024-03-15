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

var punch_counter_max: int = 2
var punch_counter: int = 0

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
			
	tick_max = owner.movement_speed/ 100

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
	if randi() % 100 <= 49: current_state = States.Attack
#endregion

#region Other methods (please try to separate and organise!)
func pressure_state(_delta):
	if tick_timer > 0: return

	var pos_aim = other_player.global_position + (Vector2(-owner.movement_speed, 0) if owner.rotation == 0 else Vector2(owner.movement_speed, 0))
	current_direction = pos_aim - owner.global_position
	if(current_direction.length() < 50 && (randi() % 100) > 100*(1-tick_max)):
		current_state = States.Attack
		print("attack")
	tick_timer = tick_max
	
func attack_state():
	#Go in and attack the player while you can still attack
	if tick_timer > 0: return
	
	var punch_pos = Vector2(-100, -50)
	if(!punch_script.is_right_arm): punch_pos.y *= -1
	if(!owner.rotation == 0): punch_pos *= -1
	current_direction = other_player.global_position + punch_pos - owner.global_position
	
	if(current_direction.length() < 80 && punch_script.can_punch() && punch_counter < punch_counter_max):
		punch_script.input_punch()
		punch_counter += 1
		tick_timer = owner.punch_speed_seconds
	elif(punch_counter >= punch_counter_max):
		current_state = States.Retreat
		punch_counter = 0
		tick_timer = owner.punch_speed_seconds
		
func retreat_state():
	if tick_timer > 0: return
	
	current_direction = owner.global_position - other_player.global_position
	if(punch_script.can_punch()):
		current_state = States.Pressure
		print("pressure")
	tick_timer = tick_max*2

func punch():
	punch_script.input_punch()

func move(dir: Vector2):
	movement_script.move_in_direction(dir)
#endregion

