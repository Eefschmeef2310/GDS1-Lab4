extends Node2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

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

#endregion

#region Godot methods
func _ready():
	prematch_screen.set_character_select("Versus")

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_prematch_screen_continue_pressed():
	prematch_screen.hide()
	battle = battle_scene.instantiate()
	add_child(battle)
	
	var p1 = prematch_screen.get_selected_blue_fighter()
	if !p1:
		p1 = default_fighter
	var p2 = prematch_screen.get_selected_red_fighter()
	if !p2:
		p2 = default_fighter
	
	battle.set_fighter_data(p1, "p1_", p2, "p2_")
	
#endregion

#region Other methods (please try to separate and organise!)

#endregion
