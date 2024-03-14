extends Resource
class_name FighterData
#Authored by Xander. Please consult for any modifications or major feature requests.

@export_group("Names")
@export var first_name: String = "Jack"
@export var middle_name: String = "Lightning"
@export var last_name: String = "Johnson"
@export var description: String = ""
@export var portrait: Texture2D

@export_group("Sprites")
@export var sprite_body: Texture2D
@export var sprite_arm: Texture2D
@export var sprite_hand: Texture2D
@export var sprite_glove: Texture2D

@export_group("Parameters")
@export var movement_speed: float = 200.0
@export var punch_attack_speed: float = 1.0
@export var punch_retract_speed: float = 1.0
@export var punch_knockback: float = 1000
@export var punch_frequency: float = 0.5
@export var punch_reach: float = 1.0
