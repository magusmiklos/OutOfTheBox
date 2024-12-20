extends Button

func _on_pressed():
	Global.map = Global.created_map
	get_tree().change_scene_to_file("res://scenes/create.tscn")
