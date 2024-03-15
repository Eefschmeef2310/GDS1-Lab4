extends Control
@onready var username_feild = $VBoxContainer/UsernameFeild
@onready var submit_button = $VBoxContainer/SubmitButton

var timer : float=5
var waiting: bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(waiting):
		timer -= delta
		if(timer<0):
			get_tree().change_scene_to_file(AirtableManager.saveLoaderScene)
	


func _on_submit_button_pressed():
	AirtableManager.saveRes.username = username_feild.text
	AirtableManager.Save()
	AirtableManager.UploadData(AirtableManager.saveRes.userID, AirtableManager.saveRes.username, AirtableManager.saveRes.highscore, AirtableManager.saveRes.gamesPlayed, AirtableManager.saveRes.playtime, AirtableManager.saveRes.version)
	timer =1
	submit_button.disabled = true
	waiting = true
	#TODO: make sure the new username is actually ready to load 


func _on_back_button_pressed():
	get_tree().change_scene_to_file(AirtableManager.saveLoaderScene)
