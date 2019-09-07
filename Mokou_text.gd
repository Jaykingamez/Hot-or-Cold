extends Label

var next_scene = preload("res://Hot or Cold3.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Setting_Of_Text(text):
	self.set_text(text)


func _on_Cirno_Cold():
	Setting_Of_Text("Brr... Cold")


func _on_Cirno_Colder():
	Setting_Of_Text("Why is it Colder")


func _on_Cirno_Coldest():
	Setting_Of_Text("Cirno! What are you doing 'ere ?")
	get_tree().change_scene_to(next_scene)

func _on_Cirno_Kaguya():
	Setting_Of_Text("Kaguya better not be involved in this") # Replace with function body.
