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


#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	set_blue_data(load("res://fighters/dummy.tres"))
	set_red_data(load("res://fighters/todd.tres"))
	
	visibility_changed.connect(became_visible)

func _process(_delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

func _on_play_button_pressed():
	continue_pressed.emit()
	
#endregion

#region Other methods (please try to separate and organise!)

func set_blue_data(data: FighterData):
	blue_name.text = data.first_name + ' "' + data.middle_name + '" ' + data.last_name
	blue_details.text = data.description
	blue_portrait.texture = data.portrait
	blue_flames.material.set('shader_parameter/darkerColor', data.accent_color)
	blue_flames.material.set('shader_parameter/brighterColor', data.main_color)

func set_red_data(data: FighterData):
	red_name.text = data.first_name + ' "' + data.middle_name + '" ' + data.last_name
	red_details.text = data.description
	red_portrait.texture = data.portrait
	red_flames.material.set('shader_parameter/darkerColor', data.accent_color)
	red_flames.material.set('shader_parameter/brighterColor', data.main_color)
	
func became_visible():
	if visible: 
		$Swoosh.play()
		$Portraits/BluePlayer.play("default")
		$Portraits/RedPlayer.play("default")
#endregion
