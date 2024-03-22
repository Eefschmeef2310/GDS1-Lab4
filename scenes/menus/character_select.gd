extends VBoxContainer
class_name character_select
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums
enum SelectionPhase {
	P1,
	P2,
	DONE
}
@export var phase: SelectionPhase = SelectionPhase.P1
var blue_fighter: FighterData
var red_fighter: FighterData

var null_data = preload("res://fighters/null.tres")

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var blue_portrait = $"../Portraits/BluePortrait"
@onready var red_portrait = $"../Portraits/RedPortrait"
@onready var round_label = $"../RoundLabel"
@onready var round_subtitle = $"../RoundSubtitle"
@onready var back_phase_button = $BackPhaseButton
@onready var play_button = $"../PlayButton"

#Other Variables (please try to separate and organise!)
var is_training := false

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	if visible:
		match phase:
			SelectionPhase.P1:
				blue_portrait.modulate.a = 0.75
				red_portrait.modulate.a = 0 if !is_training else 1
				back_phase_button.hide()
				play_button.hide()
			SelectionPhase.P2:
				blue_portrait.modulate.a = 1
				red_portrait.modulate.a = 0.75 if !is_training else 1
				back_phase_button.show()
				play_button.hide()
			SelectionPhase.DONE:
				blue_portrait.modulate.a = 1
				red_portrait.modulate.a = 1
				back_phase_button.show()
				play_button.show()
#endregion

#region Signal methods

func _on_fighter_select_hover_fighter(data):
	match phase:
		SelectionPhase.P1:
			owner.set_blue_data(data)
		SelectionPhase.P2:
			owner.set_red_data(data)
		SelectionPhase.DONE:
			pass

func _on_fighter_select_select_fighter(data):
	match phase:
		SelectionPhase.P1:
			blue_fighter = data
			phase = SelectionPhase.P2 if !is_training else SelectionPhase.DONE
			if !is_training:
				owner.set_red_data(data)
			$"../Swoosh".play()
		SelectionPhase.P2:
			red_fighter = data
			$"../Swoosh".play()
			phase = SelectionPhase.DONE
		SelectionPhase.DONE:
			pass

func _on_back_phase_button_pressed():
	match phase:
		SelectionPhase.P1:
			pass
		SelectionPhase.P2:
			phase = SelectionPhase.P1
			if !is_training:
				print("setting null data")
				owner.set_red_data(null_data)
		SelectionPhase.DONE:
			phase = SelectionPhase.P2  if !is_training else SelectionPhase.P1

#endregion

#region Other methods (please try to separate and organise!)

#endregion
