extends Button





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_pressed():
	Global.editor_selected_block = str(get_groups()[0])
