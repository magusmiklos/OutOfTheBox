extends Button

func _on_pressed():
	Global.map = Global.created_map
	Global.is_create_menu_visible = false
	get_tree().change_scene_to_file("res://scenes/create.tscn")
