extends Node2D
#class_name
#Authored by Xander & Tom. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var prematch_screen = $PrematchScreen
@onready var default_fighter = preload("res://fighters/jack.tres")
@onready var battle_scene: PackedScene = preload("res://scenes/gamemodes/battle.tscn")
@onready var battle: Battle

#Other Variables (please try to separate and organise!)
@export_group("syncronised variables")
var p1_selected_fighter_path : String = "res://fighters/null.tres"
var p2_selected_fighter_path : String = "res://fighters/null.tres"
@export_group("node references")
@export var character_selector : VBoxContainer

#endregion

#region Godot methods
func _ready():
	prematch_screen.set_character_select("Versus")
	character_selector.hide()

func _process(_delta):
	#if i am the server, show the fighters until i pick one then hide them and shwo them to p2 (client) 
	
	if multiplayer.is_server(): # (p1)
		if(character_selector.phase == character_selector.SelectionPhase.P1 and multiplayer.get_peers().size() > 0):
			character_selector.show()
		if(character_selector.phase == character_selector.SelectionPhase.P2):
			character_selector.hide()
	else: # is client (p2)
		if(character_selector.phase == character_selector.SelectionPhase.P1):
			character_selector.hide()
		if(character_selector.phase == character_selector.SelectionPhase.P2):
			character_selector.show()
	pass
#endregion

#region Signal methods

func _on_prematch_screen_continue_pressed():
	prematch_screen.hide()
	battle = battle_scene.instantiate()
	battle.game_ended.connect(_on_battle_game_ended)
	add_child(battle)
	
	var p1 = prematch_screen.get_selected_blue_fighter()
	if !p1:
		p1 = default_fighter
	var p2 = prematch_screen.get_selected_red_fighter()
	if !p2:
		p2 = default_fighter
	
	battle.set_fighter_data(p1, "p1_", p2, "p2_")

func _on_battle_game_ended(blue_score: int, red_score: int, timer:int, champ_score:int):
	AirtableManager.CasualGameComplete(timer)

#endregion

#region Other methods (please try to separate and organise!)

#endregion
