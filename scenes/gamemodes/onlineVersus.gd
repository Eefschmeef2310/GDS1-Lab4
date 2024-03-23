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
#var p1_selected_fighter_path : String = "res://fighters/null.tres"
#var p2_selected_fighter_path : String = "res://fighters/null.tres"
#var p1_picked : bool = false
#var p2_picked : bool = false
@export_group("node references")
@export var character_selector : VBoxContainer

#endregion

#region Godot methods
func _ready():
	prematch_screen.set_character_select("Versus")
	character_selector.hide()
	GlobalSteam.fighter_selected.connect(setFighterDisplay)

func _process(_delta):
	
	
	
	#if i am the server, show the fighters until i pick one then hide them and shwo them to p2 (client) 
	
	
	
	if multiplayer.is_server(): # (p1)
		if(character_selector.phase == character_selector.SelectionPhase.P1 and multiplayer.get_peers().size() > 0):
			character_selector.show()
		else:
			character_selector.hide()
	else: # is client (p2)
		
		if(character_selector.phase == character_selector.SelectionPhase.P2):
			character_selector.show()
		else:
			character_selector.hide()
	pass
#endregion

#region Signal methods


func _on_prematch_screen_continue_pressed():
	online_coninue_button_pressed.rpc()

@rpc("call_local")
func online_coninue_button_pressed():
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

func setFighterDisplay(player : int, fighterName : String):
	print(str(player)+fighterName)
	if player == 1:
		
		prematch_screen.set_blue_data(load(name_to_fighter_path(fighterName)))
		character_selector.blue_fighter = load(name_to_fighter_path(fighterName))
	else:
		
		prematch_screen.set_red_data(load(name_to_fighter_path(fighterName)))
		character_selector.phase = character_selector.SelectionPhase.DONE
		character_selector.red_fighter = load(name_to_fighter_path(fighterName))
		$PrematchScreen/PlayButton.show()
	pass

func name_to_fighter_path(first_name: String) -> String:
	match first_name:
		"Dan": return "res://fighters/dummy.tres"
		"Jack": return "res://fighters/jack.tres"
		"John": return "res://fighters/jack.tres"
		"Mike": return "res://fighters/mike.tres"
		"Todd": return "res://fighters/todd.tres"
		"Willie": return "res://fighters/willie.tres"
		_: return "res://fighters/dummy.tres"
			
#endregion

#region Other methods (please try to separate and organise!)

#endregion
