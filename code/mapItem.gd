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
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("click") and texture == PURPLE:
		texture = null


func _on_area_2d_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("click"):
		texture = PURPLE	
		Global.ab = get_parent().get_groups()[0].split(" ")

	elif Input.is_action_just_released("click"):
		var xy = get_parent().get_groups()[0].split(" ")
		
		var a = int(Global.ab[0])
		var b = int(Global.ab[1])
		
		if Global.ab == xy:
			setSelfTexture(str(a)+" "+str(b))
			Global.created_map[a][b] = Global.editor_selected_block
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
		

		if len(al) == len(bl):
			for i in range(len(al)):
				setSelfTexture(str(al[i])+" "+str(bl[i]))
				Global.created_map[al[i]][bl[i]] = Global.editor_selected_block


		elif len(al) > len(bl):
			var adiv = int(ceil(float(len(al))/float(len(bl))))
			
			var j = -1
			for i in range(len(al)):
				if i % adiv == 0:
					j += 1
				if j > len(bl)-1:
					j = len(bl)-1
				setSelfTexture(str(al[i])+" "+str(bl[j]))
				Global.created_map[al[i]][bl[j]] = Global.editor_selected_block
		else:
			
			var bdiv = int(ceil(float(len(bl))/float(len(al))))
			
			var j = -1
			for i in range(len(bl)):
				if i % bdiv == 0:
					j += 1
				if j > len(al)-1:
					j = len(al)-1
				setSelfTexture(str(al[j])+" "+str(bl[i]))
				Global.created_map[al[j]][bl[i]] = Global.editor_selected_block
				
	if Input.is_action_pressed("rightclick"):
		var xy = get_parent().get_groups()[0].split(" ")
		get_tree().get_nodes_in_group(str(int(xy[0]))+" "+str(int(xy[1])))[0].get_child(0).texture = null
		Global.created_map[int(xy[0])][int(xy[1])] = "E"
		
				
			
				
			
		


func _on_area_2d_mouse_entered():
	if texture == null or texture == NULL:
		texture = GRAY


func _on_area_2d_mouse_exited():
	if texture == null or texture == NULL or texture == GRAY:
		texture = null

func setSelfTexture(s):
	if Global.editor_selected_block == "X":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = DARK
	elif Global.editor_selected_block == "I":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = BLUE
	elif Global.editor_selected_block == "P":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = PINK
	elif Global.editor_selected_block == "S":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = ORANGE
	elif Global.editor_selected_block == "F":
		get_tree().get_nodes_in_group(s)[0].get_child(0).texture = LEMON
