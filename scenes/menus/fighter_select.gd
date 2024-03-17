extends PanelContainer
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal hover_fighter(data: FighterData)
signal select_fighter(data: FighterData)

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")
@export var fighter: FighterData

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	if fighter:
		set_fighter(fighter)

func _process(delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

func set_fighter(data: FighterData):
	fighter = data
	$BG/Icon.texture = data.icon
	var stylebox = $BG.get_theme_stylebox("panel", "PanelContainer").duplicate()
	stylebox.bg_color = data.main_color.darkened(0.25)
	$BG.add_theme_stylebox_override("panel", stylebox)

#endregion


func _on_mouse_entered():
	hover_fighter.emit(fighter)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		select_fighter.emit(fighter)
