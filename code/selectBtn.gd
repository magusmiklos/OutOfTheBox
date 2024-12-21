extends Button


func _on_pressed():
	if str(get_groups()[0]) == "0":
		Global.is_chaos_selected = true
	else:
		Global.is_chaos_selected = false
