extends Node2D
class_name BaseLevel
#Authored by Xander. Please consult for any modifications or major feature requests.

signal countdown_complete
signal slowmo_complete
signal blue_player_hit
signal red_player_hit

@onready var blue_player := $"Blue Player"
@onready var red_player := $"Red Player"
@onready var countdown_label = $CountdownUI/Label
@onready var countdown_sub = $CountdownUI/Sub
@onready var camera = $Camera

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	if multiplayer.is_server():
		print("peer id?" + str(multiplayer.get_peers()[0]))
		var player2id = multiplayer.get_peers()[0]
		setAuthorities(player2id).rpc()
	pass

@rpc("call_local")
func setAuthorities(id : int):
	
	red_player.set_multiplayer_authority(id, true)
	blue_player.set_multiplayer_authority(1, true)

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_blue_player_hit(_knockback_power):
	camera.add_trauma(1)
	blue_player_hit.emit()

func _on_red_player_hit(_knockback_power):
	camera.add_trauma(1)
	red_player_hit.emit()
	
#endregion

#region Other methods (please try to separate and organise!)

func start_countdown():
	blue_player.toggle_movement(false)
	red_player.toggle_movement(false)
	await get_tree().create_timer(0.01).timeout
	red_player.toggle_movement(false)
	countdown_sub.show()
	countdown_label.text = "3"
	$CountdownSound.play()
	
	await get_tree().create_timer(0.8, false, false, false).timeout
	countdown_label.text = "2"
	$CountdownSound.play()
	
	await get_tree().create_timer(0.8, false, false, false).timeout
	countdown_label.text = "1"
	$CountdownSound.play()
	
	await get_tree().create_timer(0.8, false, false, false).timeout
	countdown_sub.hide()
	countdown_label.text = "FIGHT!"
	blue_player.toggle_movement(true)
	red_player.toggle_movement(true)
	$BattleMusic.play()
	$StartSound.play()
	countdown_complete.emit()
	
	await get_tree().create_timer(0.75, false, false, false).timeout
	countdown_label.text = ""

func start_slowmo():
	$BattleMusic.stop()
	$EndSound.play()
	
	blue_player.toggle_movement(false)
	red_player.toggle_movement(false)
	Engine.time_scale = 0.25
	countdown_label.text = "GAME!"
	
	await get_tree().create_timer(2.5, false, false, true).timeout
	Engine.time_scale = 1
	countdown_label.text = ""
	slowmo_complete.emit()

func get_blue_player():
	return blue_player

func get_red_player():
	return red_player

func set_player_data(blue: FighterData, red: FighterData, use_alternate := false):
	$Ring/BluePost.self_modulate = blue.battle_color
	$Ring/RedPost.self_modulate = red.battle_color if !use_alternate else red.alt_battle_color

#endregion
