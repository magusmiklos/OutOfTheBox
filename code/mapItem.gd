extends Sprite2D

const PINK = preload("res://img/pink.png")
const BLUE = preload("res://img/blue.png")
const ORANGE = preload("res://img/orange.png")
const LEMON = preload("res://img/lemon.png")
const DARK = preload("res://img/dark.png")
const OPACITY = preload("res://img/opacity.png")
const NULL = preload("res://img/null.png")
const PURPLE = preload("res://img/purple.png")
const GRAY = preload("res://img/gray.png")
const BLACK_OPA = preload("res://img/blackOPA.png")
const KEY = preload("res://Key.gdshader")



func _on_area_2d_input_event(viewport, event, shape_idx):
	if Global.is_create_menu_visible:
		return
	
	
	if Input.is_action_just_pressed("click"):
		Global.ab = get_parent().get_groups()[0].split(" ")

	elif Input.is_action_just_released("click"):
		var xy = get_parent().get_groups()[0].split(" ")
		
		var x = int(xy[0])
		var y = int(xy[1])
		
		if Global.editor_selected_block == "P" and !does_player_exists():
			setSelfTexture(get_parent().get_groups()[0],Global.editor_selected_block)
			Global.created_map[x][y] = Global.editor_selected_block
			return
		elif Global.editor_selected_block == "P" and does_player_exists():
			return
		
		var a = int(Global.ab[0])
		var b = int(Global.ab[1])
		
		if x > a:
			var temp = a
			a = x
			x = temp
			
		if y > b:
			var temp = b
			b = y
			y = temp
		
		for i in range(len(Global.created_map)):
			for j in range(len(Global.created_map[i])):
				if i <= a and i >= x and j <= b and j >= y:
					setSelfTexture(str(i)+" "+str(j),Global.editor_selected_block)
					Global.created_map[i][j] = Global.editor_selected_block
				
	if Input.is_action_just_pressed("rightclick"):
		Global.cd = get_parent().get_groups()[0].split(" ")
	if Input.is_action_pressed("rightclick"):
		var xy = get_parent().get_groups()[0].split(" ")
		
		var a = int(Global.cd[0])
		var b = int(Global.cd[1])
		
		var x = int(xy[0])
		var y = int(xy[1])
		
		if x > a:
			var temp = a
			a = x
			x = temp
			
		if y > b:
			var temp = b
			b = y
			y = temp
		
		for i in range(len(Global.created_map)):
			for j in range(len(Global.created_map[i])):
				if i <= a and i >= x and j <= b and j >= y:
					get_tree().get_nodes_in_group(str(i)+" "+str(j))[0].get_child(0).texture = BLACK_OPA
					get_tree().get_nodes_in_group(str(i)+" "+str(j))[0].get_child(0).material = null
					Global.created_map[i][j] = "E"
		
		
				
			
				
			
		


func _on_area_2d_mouse_entered():
	Global.editor_cursor = global_position
	if texture == BLACK_OPA:
		texture = GRAY


func _on_area_2d_mouse_exited():
	if texture == BLACK_OPA or texture == GRAY:
		texture = BLACK_OPA

func setSelfTexture(s,editor_selected_block):
	if editor_selected_block == "X":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = DARK
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "I":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = BLUE
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "P":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = PINK
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "S":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = ORANGE
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "F":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = LEMON
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "E":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = BLACK_OPA
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = null
	elif editor_selected_block == "K":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = LEMON
		var shader_material = ShaderMaterial.new()
		shader_material.shader = KEY
		get_tree().get_nodes_in_group(s)[0].get_child(0).material = shader_material
		

		
func does_player_exists():
	for i in range(len(Global.created_map)):
		for j in range(len(Global.created_map[i])):
			if Global.created_map[i][j] == "P":
				return true
	return false
