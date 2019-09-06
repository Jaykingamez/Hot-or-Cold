extends "piece.gd"
signal Cold
signal Colder
signal Coldest
signal Kaguya

func _ready():
	#self.connect("Seen", self, "mokou_here" )
	pass




func _on_cirno_feel_area_entered(area):
	if area.name == "view" :
		emit_signal("Cold")
	elif area.name == "more_hot":
		emit_signal("Colder")
	elif area.name == "most_hot":
		emit_signal("Coldest")


func _on_cirno_feel_area_exited(area):
	if area.name == "view" :
		emit_signal("Kaguya")
	elif area.name == "more_hot":
		emit_signal("Cold")
	elif area.name == "most_hot":
		emit_signal("Colder") # Replace with function body.
