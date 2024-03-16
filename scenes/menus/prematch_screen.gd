extends CanvasLayer
class_name PrematchScreen
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal continue_pressed()

#Enums

#Constants
@onready var blue_flames = $Background/BlueFlames
@onready var red_flames = $Background/RedFlames
@onready var round_label = $RoundLabel
@onready var round_subtitle = $RoundSubtitle
@onready var vs = $VS
@onready var blue_portrait = $Portraits/BluePortrait
@onready var red_portrait = $Portraits/RedPortrait
@onready var blue_name = $BlueDetails/Name
@onready var blue_details = $BlueDetails/Details
@onready var red_name = $RedDetails/Name
@onready var red_details = $RedDetails/Details
@onready var play_button = $PlayButton

@onready var character_select = $CharacterSelect

@onready var prematch_music = $PrematchMusic

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	set_blue_data(load("res://fighters/null.tres"))
	set_red_data(load("res://fighters/null.tres"))
	
	visibility_changed.connect(became_visible)
	became_visible()

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_play_button_pressed():
	continue_pressed.emit()
	
#endregion

#region Other methods (please try to separate and organise!)

func set_character_select(title: String):
	round_label.text = title
	round_subtitle.text = "Select your fighter"
	vs.hide()
	if title == "Training":
		set_red_data(load("res://fighters/dummy.tres"))
		character_select.is_training = true
	character_select.show()

func set_blue_data(data: FighterData):
	blue_name.text = data.first_name + ' "' + data.middle_name + '" ' + data.last_name if data.first_name else ""
	blue_details.text = data.description
	blue_portrait.texture = data.portrait
	blue_flames.material.set('shader_parameter/darkerColor', data.accent_color)
	blue_flames.material.set('shader_parameter/brighterColor', data.main_color)
	$Portraits/BluePlayer.stop()
	$Portraits/BluePlayer.play("default")

func set_red_data(data: FighterData):
	red_name.text = data.first_name + ' "' + data.middle_name + '" ' + data.last_name if data.first_name else "   "
	red_details.text = data.description
	red_portrait.texture = data.portrait
	red_flames.material.set('shader_parameter/darkerColor', data.accent_color)
	red_flames.material.set('shader_parameter/brighterColor', data.main_color)
	$Portraits/RedPlayer.stop()
	$Portraits/RedPlayer.play("default")
	
func became_visible():
	if visible: 
		$Swoosh.play()
		$PrematchMusic.play()
		$Portraits/BluePlayer.play("default")
		$Portraits/RedPlayer.play("default")
	else:
		$PrematchMusic.stop()

func get_selected_blue_fighter():
	return character_select.blue_fighter

func get_selected_red_fighter():
	return character_select.red_fighter

#endregion
