extends Button



func _on_pressed():
	Global.editor_selected_block = str(get_groups()[0])


func _on_mouse_entered():
	Global.editor_motions = false


func _on_mouse_exited():
	Global.editor_motions = true
