extends Control
@onready var username_feild = $VBoxContainer/UsernameFeild


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_button_pressed():
	AirtableManager.saveRes.username = username_feild.text
	AirtableManager.Save()
	AirtableManager.UploadData(AirtableManager.saveRes.userID, AirtableManager.saveRes.username, AirtableManager.saveRes.highscore, AirtableManager.saveRes.gamesPlayed, AirtableManager.saveRes.playtime, AirtableManager.saveRes.version)
	get_tree().change_scene_to_file(AirtableManager.saveLoaderScene)
	#TODO: make sure the new username is actually ready to load 
