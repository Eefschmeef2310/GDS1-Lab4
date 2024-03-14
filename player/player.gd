extends CharacterBody2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals
signal hit(power : float)

#Enums

#Constants

#Exported Variables
@export_group("Statistics")
#@export_subgroup("Subgroup")
@export var movement_speed: float = 200
@export var punch_speed_scale : float = 1.
@export var retract_speed_scale : float = 1.
@export var knockback_power : float = 1000

#Onready Variables

#Other Variables (please try to separate and organise!)

#endregion

#region Godot methods
func _ready():
	#Runs when all children have entered the tree
	pass

func _process(_delta):
	#Debug for knockback
	#if(Input.is_action_just_pressed("p2_down")): 
		#hit.emit()
	pass
#endregion

#region Signal methods

func _on_head_hurtbox_area_entered(area):
	if $"AudioPlayers/Hit" : $"AudioPlayers/Hit".play()
	hit.emit(area.owner.knockback_power)

#endregion

#region Other methods (please try to separate and organise!)
func load_resource(m_s: float, p_s_s : float, r_s_s : float, k_p : float):
	movement_speed = m_s
	punch_speed_scale = p_s_s
	retract_speed_scale = r_s_s
	knockback_power = k_p
	
#endregion
