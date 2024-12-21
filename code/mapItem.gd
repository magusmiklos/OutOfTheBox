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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("click") and texture == PURPLE:
		texture = BLACK_OPA


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Global.is_create_menu_visible:
		return
	
	
	if Input.is_action_just_pressed("click"):
		texture = PURPLE
		Global.ab = get_parent().get_groups()[0].split(" ")

	elif Input.is_action_just_released("click"):
		var xy = get_parent().get_groups()[0].split(" ")
		
		var a = int(Global.ab[0])
		var b = int(Global.ab[1])
		
		if Global.ab == xy:
			if Global.editor_selected_block != "P" or !does_player_exists():
				setSelfTexture(str(a)+" "+str(b),Global.editor_selected_block)
				Global.created_map[a][b] = Global.editor_selected_block
				return
			else:
				setSelfTexture(str(a)+" "+str(b),Global.created_map[a][b])
				return
		
		var x = int(xy[0])
		var y = int(xy[1])
		
		var al = [a]
		var bl = [b]
		
		var astep = 1
		if a > x:
			astep = -1
			
		var bstep = 1
		if b > y:
			bstep = -1
		
		for i in range(a,x,astep):
			if a < x:
				a += 1
			else:
				a -= 1
			al.append(a)
		for i in range(b,y,bstep):
			if b < y:
				b += 1
			else:
				b -= 1
			bl.append(b)
		

		if len(al) == len(bl) and Global.editor_selected_block != "P":
			for i in range(len(al)):
				setSelfTexture(str(al[i])+" "+str(bl[i]),Global.editor_selected_block)
				Global.created_map[al[i]][bl[i]] = Global.editor_selected_block


		elif len(al) > len(bl) and Global.editor_selected_block != "P":
			var adiv = int(ceil(float(len(al))/float(len(bl))))
			
			var j = -1
			for i in range(len(al)):
				if i % adiv == 0:
					j += 1
				if j > len(bl)-1:
					j = len(bl)-1
				setSelfTexture(str(al[i])+" "+str(bl[j]),Global.editor_selected_block)
				Global.created_map[al[i]][bl[j]] = Global.editor_selected_block
		elif Global.editor_selected_block != "P":
			
			var bdiv = int(ceil(float(len(bl))/float(len(al))))
			
			var j = -1
			for i in range(len(bl)):
				if i % bdiv == 0:
					j += 1
				if j > len(al)-1:
					j = len(al)-1
				setSelfTexture(str(al[j])+" "+str(bl[i]),Global.editor_selected_block)
				Global.created_map[al[j]][bl[i]] = Global.editor_selected_block
				
				
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
