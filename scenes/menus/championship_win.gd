extends CanvasLayer
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")

#Onready Variables
@onready var hits = $VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/Stats/Hits
@onready var damage = $VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/Stats/Damage
@onready var clear_time = $VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/Stats/ClearTime
@onready var final_score = $VBoxContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/Stats/FinalScore
@onready var particles = $VBoxContainer/HBoxContainer/Art/TextureRect2/Particles


#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(delta):
	#Runs per frame
	pass
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

#endregion
