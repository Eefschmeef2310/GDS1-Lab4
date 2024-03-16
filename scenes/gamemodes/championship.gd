extends Node2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants
const PlayerData: FighterData = preload("res://fighters/jack.tres")
const Opponents: Array[FighterData] = [
	preload("res://fighters/todd.tres"),
	preload("res://fighters/mike.tres"),
	preload("res://fighters/willie.tres"),
	preload("res://fighters/john.tres"),
]
const RoundNames: PackedStringArray = [
	"Round 1",
	"Round 2",
	"Semifinals",
	"Grand Finals"
]
const BattleScene: PackedScene = preload("res://scenes/gamemodes/battle.tscn")

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var prematch_screen = $PrematchScreen
@onready var championship_win = $ChampionshipWin

#Other Variables (please try to separate and organise!)
var current_round: int = -1
var total_score: int = 0
var battle: Node
#total player hits
#total enemy hits
#total clear time

#endregion

#region Godot methods
func _ready():
	start_next_round()

func _process(_delta):
	#Runs per frame
	if Input.is_action_just_pressed("debug_continue"):
		start_next_round()
#endregion

#region Signal methods

func _on_prematch_screen_continue_pressed():
	print("clicky!")
	start_battle()

func _on_battle_continue_championship(new_score: int):
	total_score = new_score
	start_next_round()

func _on_finish_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

#endregion

#region Other methods (please try to separate and organise!)

func start_battle():
	prematch_screen.hide()
	battle = BattleScene.instantiate()
	add_child(battle)
	battle.set_fighter_data(PlayerData, "p1_", Opponents[current_round], "ai")
	battle.end_screen.set_championship()
	battle.championship_score = total_score
	battle.continue_championship.connect(_on_battle_continue_championship)
	

func start_next_round():
	current_round += 1
	if battle:
		battle.queue_free()
		
	if current_round < Opponents.size():
		prematch_screen.show()
		prematch_screen.set_blue_data(PlayerData)
		prematch_screen.set_red_data(Opponents[current_round])
		prematch_screen.round_label.text = RoundNames[current_round]
		prematch_screen.round_subtitle.text = "Current Score: " + str(total_score)
	
	else:
		championship_win.show()

#endregion
