extends Camera2D

var zoom_step = 0.1
var min_zoom = 0.5
var max_zoom = 3.0

var min_pos = Vector2(-1000, -800)
var max_pos = Vector2(1000, 800)

var old_zoom = Vector2(1,1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if !Global.is_create_menu_visible:
			old_zoom = zoom
			zoom = Vector2(1,1)
		else:
			zoom = old_zoom
	
	if Input.is_action_just_pressed("wup") and !Global.is_create_menu_visible:
		zoom_in()
	if Input.is_action_just_pressed("wdown") and !Global.is_create_menu_visible:
		zoom_out()
	
	var move_vector = Vector2()
	
	if Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		move_vector = Vector2(-158, -158) * delta
	elif Input.is_action_pressed("left") and Input.is_action_pressed("down"):
		move_vector = Vector2(-158, 158) * delta
	elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
		move_vector = Vector2(158, -158) * delta
	elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
		move_vector = Vector2(158, 158) * delta
	elif Input.is_action_pressed("left"):
		move_vector = Vector2(-250, 0) * delta
	elif Input.is_action_pressed("right"):
		move_vector = Vector2(250, 0) * delta
	elif Input.is_action_pressed("up"):
		move_vector = Vector2(0, -250) * delta
	elif Input.is_action_pressed("down"):
		move_vector = Vector2(0, 250) * delta
		
	self.position += move_vector
	self.position = clamp_pos(self.position)

func zoom_out():
	var new_zoom = zoom - Vector2(zoom_step, zoom_step)
	zoom = clamp_zoom(new_zoom)

func zoom_in():
	var new_zoom = zoom + Vector2(zoom_step, zoom_step)
	zoom = clamp_zoom(new_zoom)
		
func clamp_zoom(new_zoom):
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	return new_zoom

func clamp_pos(pos):
	pos.x = clamp(pos.x, min_pos.x, max_pos.x)
	pos.y = clamp(pos.y, min_pos.y, max_pos.y)
	return pos
