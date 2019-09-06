extends "piece.gd"
signal Hot
signal Hotter
signal Hottest
signal Greatest

func _ready():
	#self.connect("Seen", self, "mokou_here" )
	pass

	

func _on_view_area_entered(area):
	if area.name == "cirno_feel":
		emit_signal("Hot")

func _on_more_hot_area_entered(area):
	if area.name == "cirno_feel":
		emit_signal("Hotter")


func _on_most_hot_area_entered(area):
	if area.name == "cirno_feel":
		emit_signal("Hottest") # Replace with function body.


func _on_view_area_exited(area):
	if area.name == "cirno_feel": # Replace with function body.
		emit_signal("Greatest")

func _on_more_hot_area_exited(area):
	if area.name == "cirno_feel":
		emit_signal("Hot") # Replace with function body.


func _on_most_hot_area_exited(area):
	if area.name == "cirno_feel":
		emit_signal("Hotter") # Replace with function body.
