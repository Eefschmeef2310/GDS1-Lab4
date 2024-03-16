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
	},
	ai = {
		move = preload("res://movement_bases/ai_movement.gd"),
		punch = preload("res://punch_bases/ai_punch.gd"),
		logic = preload("res://ai_scripts/ai_script.gd")
	}
}
@onready var movement_node: Node = $Scripts/Movement
@onready var punches_node: Node = $Scripts/Punches
@onready var ai_node: Node = $Scripts/AI

#Exported Variables
@export_group("Statistics")
#@export_subgroup("Subgroup")
@export var movement_speed: float = 200
@export var punch_speed_seconds : float = 0.2
@export var retract_speed_seconds : float = 0.6
@export var knockback_power : float = 1000
@export var punch_frequency : float = 0.6

@export var tick_speed: float = 0.5
@export var aggressive_chance_scale: float = 1
@export var hover_distance: float = 200
@export var max_consec_punches: int = 2
@export var can_prep_punch: bool = false

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
	if $"AudioPlayers/CrowdCheer" : $"AudioPlayers/CrowdCheer".play()
	hit.emit(area.owner.knockback_power)

#endregion

#region Other methods (please try to separate and organise!)
func load_resource(data: FighterData, use_alternate := false):
	# Parameters
	movement_speed = data.movement_speed
	punch_speed_seconds = data.punch_attack_speed
	retract_speed_seconds = data.punch_retract_speed
	knockback_power = data.punch_knockback
	punch_frequency = data.punch_frequency
	
	# AI params
	tick_speed = data.tick_speed
	aggressive_chance_scale = data.aggressive_chance_scale
	hover_distance = data.hover_distance
	max_consec_punches = data.max_consec_punches
	can_prep_punch = data.can_prep_punch
	
	# Sprites
	$Body.texture = data.sprite_body
	$Body/LArm.texture = data.sprite_arm
	$Body/RArm.texture = data.sprite_arm
	$Body/LArm/LHand.texture = data.sprite_hand
	$Body/RArm/RHand.texture = data.sprite_hand
	if data.sprite_glove:
		$Body/LArm/LHand/Glove.texture = data.sprite_glove
		$Body/RArm/RHand/Glove.texture = data.sprite_glove
	$Body/LArm/LHand/Glove.self_modulate = data.battle_color if !use_alternate else data.alt_battle_color
	$Body/RArm/RHand/Glove.self_modulate = data.battle_color if !use_alternate else data.alt_battle_color

func toggle_movement(toggle: bool):
	movement_node.can_input = toggle

func set_as_player(prefix: String):
	movement_node.set_script(InputScripts.player.move)
	movement_node.input_prefix = prefix
	punches_node.set_script(InputScripts.player.punch)
	punches_node.input_prefix = prefix
	ai_node.set_script(null)

func set_as_dummy():
	movement_node.set_script(null)
	punches_node.set_script(InputScripts.dummy.punch)
	ai_node.set_script(null)

#Arguments can be added to change the ai script loaded, so different characters have different playstyles
func set_as_ai():
	movement_node.set_script(InputScripts.ai.move)
	punches_node.set_script(InputScripts.ai.punch)
	#Basic AI script for now
	ai_node.set_script(InputScripts.ai.logic)
	#ai_node.set_script(null)
	
#endregion
