extends Node

signal fighter_selected(player : int, fighterName : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_environment("SteamAppID", str(2899410))
	OS.set_environment("SteamGameID", str(2899410))
	Steam.steamInitEx()
	multiplayer.server_disconnected.connect(ConnectionClosed)
	
	## Spacewar (test app) : 480
	## untitiled wizard game (real app) : 2899410

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Steam.run_callbacks()

@rpc("any_peer","call_local")
func talk(message : String):
	print("Talk: " + message)
	
@rpc("any_peer","call_local")
func fighterSelected(player : int, fighterName : String):
	print("Player " + str(player) + " picked: " + fighterName)
	fighter_selected.emit(player, fighterName)


func ConnectionClosed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

@rpc("authority")
func EndConnection():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	#multiplayer.multiplayer_peer = null

