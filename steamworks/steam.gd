extends Node

signal fighter_selected(player : int, fighter : FighterData)

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_environment("SteamAppID", str(480))
	OS.set_environment("SteamGameID", str(480))
	Steam.steamInitEx()
	
	## Spacewar (test app) : 480
	## untitiled wizard game (real app) : 2899410

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Steam.run_callbacks()

@rpc("any_peer")
func talk(message : String):
	print("Talk: " + message)
	
@rpc("any_peer")
func fighterSelected(player : int, fighter : FighterData):
	print("Player " + str(player) + " picked: " + fighter.first_name)
	fighter_selected.emit(player, fighter)
