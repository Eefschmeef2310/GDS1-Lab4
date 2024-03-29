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
	"Grand Final"
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
var hits: int
var damage: int
var clear_time: float

#endregion

#region Godot methods
func _ready():
	championship_win.hide()
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

func _on_battle_game_ended(blue_score: int, red_score: int, timer:int, champ_score:int):
	hits += blue_score
	damage += red_score
	clear_time += (60 - timer)
	total_score = champ_score
	if red_score >= blue_score or current_round == Opponents.size() - 1:
		print("Submitting championship set.")
		AirtableManager.ChampionshipGameComplete(total_score, clear_time, current_round + 1, hits, damage, current_round)

func _on_battle_continue_championship(new_score: int):
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
	battle.game_ended.connect(_on_battle_game_ended)
	

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
		championship_win.hits.text = "Hits Landed: " + str(hits)
		championship_win.damage.text = "Hits Taken: " + str(damage)
		championship_win.clear_time.text = "Clear Time: " + get_timer_string_from_seconds(clear_time)
		championship_win.final_score.text = "Final Score: " + str(total_score)
		championship_win.particles.emitting = true
		$WinStream.play()

func get_timer_string_from_seconds(time_elapsed := 0.0):
	var minutes := time_elapsed / 60
	var seconds := fmod(time_elapsed, 60)
	var time_string := "%02d:%02d" % [minutes, seconds]
	return time_string

#endregion
