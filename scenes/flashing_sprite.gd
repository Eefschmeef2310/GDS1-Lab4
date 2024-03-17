extends Sprite2D

var i = 0
var freq = 10
var fade_col = Color.DARK_GRAY
@export var print := false

func _process(delta):
	i += delta
	var val = (sin(i*freq) + 1) / 2
	if print:
		print(val)
	self_modulate = Color.WHITE.lerp(fade_col, val)
	
