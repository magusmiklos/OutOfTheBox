extends Node2D
@onready var menu = $"../Camera2D/Menu"
@onready var back = $"../Back"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var map = $"../Map"

var player_x = null
var player_y = null

var fall = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if menu.visible:
			menu.visible = false
			back.get_material().set_shader_parameter("speed",1)
		else:
			menu.visible = true
			back.get_material().set_shader_parameter("speed",0.1)
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		var done = false
		for i in range(len(Global.map)):
			for j in range(len(Global.map[i])):
				if Global.map[i][j] == "P":
					player_x = j
					player_y = i
					done = true
				if done:
					break
			if done:
				break
	if Input.is_action_just_pressed("right"):
		if player_x < len(Global.map[player_y])-1:
			if Global.map[player_y][player_x] == "P" and Global.map[player_y][player_x+1] == "E":
				move_right()
	if Input.is_action_just_pressed("left"):
		if player_x > 0:
			if Global.map[player_y][player_x] == "P" and Global.map[player_y][player_x-1] == "E":
				move_left()

func calculate_fall(y,x):
	var fall = 0
	
	for i in range(y+1,len(Global.map)):
		if Global.map[i][x] == "E":
			fall += 1
		else:
			break
	return fall
	
func move_left():
	Global.map[player_y][player_x] = "E"
	fall = calculate_fall(player_y,player_x-1)
	Global.map[player_y+fall][player_x-1] = "P" 
	map.create_map()

func move_right():
	Global.map[player_y][player_x] = "E"
	fall = calculate_fall(player_y,player_x+1)
	Global.map[player_y+fall][player_x+1] = "P" 
	map.create_map()
	
