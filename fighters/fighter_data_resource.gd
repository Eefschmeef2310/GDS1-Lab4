extends Resource
class_name FighterData
#Authored by Xander. Please consult for any modifications or major feature requests.

@export_group("Names")
@export var first_name: String = "Jack"
@export var middle_name: String = "Lightning"
@export var last_name: String = "Johnson"
@export_multiline var description: String = ""
@export var portrait: Texture2D
@export var icon: Texture2D
@export var battle_color: Color = Color.WHITE
@export var alt_battle_color: Color = Color.WHITE
@export var main_color: Color = Color.BLUE
@export var accent_color: Color = Color.CYAN

@export_group("Sprites")
@export var sprite_body: Texture2D
@export var sprite_arm: Texture2D
@export var sprite_hand: Texture2D
@export var sprite_glove: Texture2D

@export_group("Parameters")
@export var movement_speed: float = 200.0
@export var punch_attack_speed: float = 0.2
@export var punch_retract_speed: float = 0.6
@export var punch_knockback: float = 1000
@export var punch_frequency: float = 0.6
# @export var punch_reach: float = 1.0

@export_group("Ai_Stuff")
@export var tick_speed: float = 0.5 #Basically Reaction Speed
@export var aggressive_chance_scale: float = 1 #Chance it will go into "attack state" when in "pressure state"
@export var hover_distance: float = 250 #Tether distance from other player when in "pressure state"
@export var max_consec_punches: int = 2 #Max proper punches in a row before going into "retreat"
@export var can_prep_punch: bool = false #If true, I will make sure I am using the right fist to punch (Set mike to true)
