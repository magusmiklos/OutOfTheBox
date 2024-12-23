extends Button


func _on_pressed():
	Global.current_map = 9
	
	Global.map = Global.maps[Global.current_map].duplicate()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
