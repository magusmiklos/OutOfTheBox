extends Sprite2D

const ORANGE = preload("res://img/orange.png")
const LEMON = preload("res://img/lemon.png")
const DARK = preload("res://img/dark.png")
const OPACITY = preload("res://img/opacity.png")
const NULL = preload("res://img/null.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("click") and texture == ORANGE:
		texture = null


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		texture = ORANGE	
		Global.ab = get_parent().get_groups()[0].split(" ")

	elif Input.is_action_just_released("click"):
		var xy = get_parent().get_groups()[0].split(" ")
		
		var a = int(Global.ab[0])
		var b = int(Global.ab[1])
		
		if Global.ab == xy:
			get_tree().get_nodes_in_group(str(a)+" "+str(b))[0].get_child(0).texture = DARK
			Global.created_map[a][b] = "X"
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
				get_tree().get_nodes_in_group(str(al[i])+" "+str(bl[i]))[0].get_child(0).texture = DARK
				Global.created_map[al[i]][bl[i]] = "X"


		elif len(al) > len(bl):
			var adiv = int(ceil(float(len(al))/float(len(bl))))
			
			var j = -1
			for i in range(len(al)):
				if i % adiv == 0:
					j += 1
				if j > len(bl)-1:
					j = len(bl)-1
				get_tree().get_nodes_in_group(str(al[i])+" "+str(bl[j]))[0].get_child(0).texture = DARK
				Global.created_map[al[i]][bl[j]] = "X"
		else:
			
			var bdiv = int(ceil(float(len(bl))/float(len(al))))
			
			var j = -1
			for i in range(len(bl)):
				if i % bdiv == 0:
					j += 1
				if j > len(al)-1:
					j = len(al)-1
				get_tree().get_nodes_in_group(str(al[j])+" "+str(bl[i]))[0].get_child(0).texture = DARK
				Global.created_map[al[j]][bl[i]] = "X"
				
	if Input.is_action_pressed("rightclick"):
		var xy = get_parent().get_groups()[0].split(" ")
		get_tree().get_nodes_in_group(str(int(xy[0]))+" "+str(int(xy[1])))[0].get_child(0).texture = null
		Global.created_map[int(xy[0])][int(xy[1])] = "E"
		
				
			
				
			
		


func _on_area_2d_mouse_entered():
	if texture == null or texture == NULL:
		texture = LEMON


func _on_area_2d_mouse_exited():
	if texture == null or texture == NULL or texture == LEMON:
		texture = null
