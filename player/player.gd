extends CharacterBody2D
class_name Player
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal hit(power : float)

#Enums

#Constants
const InputScripts: Dictionary = {
	player = {
		move = preload("res://movement_bases/player_movement.gd"),
		punch = preload("res://punch_bases/player_punch.gd")
	},
	dummy = {
		move = preload("res://movement_bases/movement_base.gd"),
		punch = preload("res://punch_bases/punch_base.gd")
	}
}
@onready var movement_node: Node = $Scripts/Movement
@onready var punches_node: Node = $Scripts/Punches

#Exported Variables
@export_group("Statistics")
#@export_subgroup("Subgroup")
@export var movement_speed: float = 200
@export var punch_speed_seconds : float = 0.2
@export var retract_speed_seconds : float = 0.6
@export var knockback_power : float = 1000
@export var punch_frequency : float = 0.6

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(_delta):
	#Debug for knockback
	#if(Input.is_action_just_pressed("p2_down")): 
		#hit.emit()
	pass
#endregion

#region Signal methods

func _on_head_hurtbox_area_entered(area):
	if $"AudioPlayers/Hit" : $"AudioPlayers/Hit".play()
	hit.emit(area.owner.knockback_power)

#endregion

#region Other methods (please try to separate and organise!)
func load_resource(data: FighterData):
	movement_speed = data.movement_speed
	punch_speed_seconds = data.punch_attack_speed
	retract_speed_seconds = data.punch_retract_speed
	knockback_power = data.punch_knockback
	punch_frequency = data.punch_frequency
	

func toggle_movement(toggle: bool):
	movement_node.can_input = toggle

func set_as_player(prefix: String):
	movement_node.set_script(InputScripts.player.move)
	movement_node.input_prefix = prefix
	punches_node.set_script(InputScripts.player.punch)
	punches_node.input_prefix = prefix

func set_as_dummy():
	movement_node.set_script(InputScripts.dummy.move)
	punches_node.set_script(InputScripts.dummy.punch)

func set_as_ai():
	pass

#endregion
