extends Camera2D

@export var decay := 0.8 #How quickly shaking will stop [0,1].
@export var max_offset := Vector2(100,75) #Maximum displacement in pixels.
@export var max_roll := 0.1 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.

var noise_y = 0 #Value used to move through the noise

var trauma := 0.0 #Current shake strength
var trauma_pwr := 3 #Trauma exponent. Use [2,3]

func _ready():
	noise.seed = randi()
	print(noise.seed)

func add_trauma(amount : float):
	zoom = Vector2(1.02, 1.02)
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 3*delta)
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	#optional
	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		offset.x = lerp(offset.x,0.0,1)
		offset.y = lerp(offset.y,0.0,1)
		rotation = lerp(rotation,0.0,1)

func shake(): 
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	rotation = max_roll * amt * noise.get_noise_2d(0, noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(1000, noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(2000, noise_y)
	
	# print(snapped(noise.get_noise_2d(1000, noise_y), 0.01))
	
