extends Node
	#class_name
#Authored by Ethan. Please consult for any modifications or major feature requests.

#region Variables
	#Other Variables (please try to separate and organise!)
var other_player : Node2D
#endregion

#region Godot methods
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player != owner:
			other_player = player
			return

func _process(_delta):
	if other_player:
		owner.rotation = deg_to_rad(180) if other_player.global_position.x < owner.global_position.x else deg_to_rad(0)
#endregion
