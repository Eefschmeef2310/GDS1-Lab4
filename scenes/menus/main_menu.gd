extends Control
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Signals

	#Enums

	#Constants
const OPTIONS = preload("res://scenes/menus/options.tscn")
const CHAMPIONSHIP = preload("res://scenes/gamemodes/championship.tscn")
const LEADERBOARD = preload("res://online/Leaderboard.tscn")
	#Exported Variables
	#@export_group("Group")
	#@export_subgroup("Subgroup")
@export var username_label : Label
@export var highscore_label : Label
	#Onready Variables
@onready var home_layer = $Home
@onready var play_layer = $Play

	#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Set visibility of exit button (button not required for web)
	$Home/HBoxContainer/VBoxContainer/Exit.visible = OS.get_name() != "Web"
	Engine.time_scale = 1
	$MenuMusic.play()
	home_layer.show()
	play_layer.hide()

func _process(_delta):
	#Runs per frame
	username_label.text = AirtableManager.saveRes.username
	highscore_label.text = "High Score: " + str(AirtableManager.saveRes.highscore)
#endregion

#region Signal methods
func _on_play_pressed():
	home_layer.hide()
	play_layer.show()

func _on_play_back_pressed():
	home_layer.show()
	play_layer.hide()

func _on_versus_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/versus.tscn")

func _on_training_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/training.tscn")

func _on_options_pressed():
	get_tree().root.add_child(OPTIONS.instantiate())
	
func _on_championship_pressed():
	get_tree().change_scene_to_file("res://scenes/gamemodes/championship.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
	
func _on_leaderboard_pressed():
	get_tree().root.add_child(LEADERBOARD.instantiate())


func _on_change_username_pressed():
	get_tree().change_scene_to_file(AirtableManager.usernameChangerScene)


func _on_logout_pressed():
	get_tree().change_scene_to_file(AirtableManager.usernamePickerScene)
#endregion

#region Other methods (please try to separate and organise!)

#endregion
