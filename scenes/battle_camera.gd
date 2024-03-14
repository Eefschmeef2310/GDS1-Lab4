extends Camera2D
#class_name
#Authored by Xander. Please consult for any modifications or major feature requests.

#region Variables
#Signals

#Enums

#Constants

#Exported Variables
#@export_group("Group")
#@export_subgroup("Subgroup")
@export var decay := 1 #How quickly shaking will stop [0,1].
@export var max_offset := Vector2(50,20) #Maximum displacement in pixels.
@export var max_roll = 0.0 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.

#Onready Variables

#Other Variables (please try to separate and organise!)
var noise_y = 0 #Value used to move through the noise

var trauma := 0.0 #Current shake strength
var trauma_pwr := 3 #Trauma exponent. Use [2,3]

#endregion

#region Godot methods
func _ready():
	noise.seed = randi()

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	#optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)
		lerp(rotation,0.0,1)
#endregion

#region Signal methods

#endregion

#region Other methods (please try to separate and organise!)

func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

func shake(): 
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	rotation = max_roll * amt * noise.get_noise_2d(noise.seed,noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2,noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3,noise_y)

#endregion
