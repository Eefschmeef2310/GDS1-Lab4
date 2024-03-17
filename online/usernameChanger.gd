## THIS IS THE USERNAME CHANGER SCRIPT
# written by Tom

extends Control
@onready var username_feild = $VBoxContainer/UsernameFeild
@onready var submit_button = $VBoxContainer/SubmitButton
@onready var error_text = $VBoxContainer/ErrorText

var timer : float=5
var waiting: bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	AirtableManager.CheckUsernameResponse.connect(OnUsernameCheckComplete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(waiting):
		timer -= delta
		if(timer<0):
			get_tree().change_scene_to_file(AirtableManager.saveLoaderScene)

func _on_submit_button_pressed():
	submit_button.disabled = true
	AirtableManager.CheckUsername(username_feild.text)


func _on_back_button_pressed():
	get_tree().change_scene_to_file(AirtableManager.saveLoaderScene)

func OnUsernameCheckComplete(result : bool):
	if(result): #username is available
		AirtableManager.saveRes.username = username_feild.text
		AirtableManager.Save()
		AirtableManager.UploadData()
		timer =1
		waiting = true
	else:
		submit_button.disabled = false
		username_feild.text = ""
		error_text.text = "Username taken\nplease pick again"
