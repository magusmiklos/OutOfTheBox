extends Node2D

const FROZEN = preload("res://prefabs/Frozen.tscn")
const KEY = preload("res://prefabs/Key.tscn")
const DOOR = preload("res://prefabs/Door.tscn")
const SOLID = preload("res://prefabs/Solid.tscn")
const ITEM = preload("res://prefabs/item.tscn")
const PLAYER_ITEM = preload("res://prefabs/PlayerItem.tscn")
@onready var camera_2d = $"../Camera2D"
@onready var map_timer = $"../MapTimer"
@onready var label = $"../Camera2D/Menu/MarginContainer2/VBoxContainer2/GridContainer/Label"
@onready var h_slider = $"../Camera2D/Menu/MarginContainer2/VBoxContainer2/GridContainer/HSlider"



var sprite = null

var calc = false

# Called when the node enters the scene tree for the first time.
func _ready():
	create_map()
	h_slider.value = 1.0-Global.speed
	map_timer.wait_time = Global.speed
	label.text = str(int(h_slider.value*100))
	get_key_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.start == false:
		calc = false
	
	if calc:
		for current_rule in len(Global.from):
			var found = false
			for i in range(len(Global.map)):
				for j in range(len(Global.map[i])):
					#edge
					if i > 0 and i < len(Global.map)-1 and j > 0 and j < len(Global.map[i])-1:
						#find where to apply wich rule
						var apply = true
						for k in range(len(Global.from[current_rule])):
							for l in range(len(Global.from[current_rule][k])):
								if Global.map[i-1+k][j-1+l] != Global.from[current_rule][k][l]:
									apply = false
									break
							if not apply:
								break
						#apply the rule			
						if apply == true:
							#print("found with rule:" + str(current_rule))
							calc = false
							for k in range(len(Global.from[current_rule])):
								for l in range(len(Global.from[current_rule][k])):
									Global.map[i-1+k][j-1+l] = Global.to[current_rule][k][l]
									
							#print(map)
							create_map()
							found = true
							break
					if found:
						break
				if found:
					break
			if found:
				break


func _on_timer_timeout():
	if Global.start:
		calc = true
	
func create_map():
	for c in get_children():
		c.queue_free()
	
	var dummy = ITEM.instantiate()
	sprite = dummy.get_child(0)
	dummy.queue_free()
	
	for i in range(len(Global.map)):
		for j in range(len(Global.map[i])):
			if Global.map[i][j] == "X":
				var item = ITEM.instantiate()
				
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "P":
				var item = PLAYER_ITEM.instantiate()
				camera_2d.position = Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "S":
				var item = SOLID.instantiate()
				
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "F":
				var item = DOOR.instantiate()
				
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "K":
				var item = KEY.instantiate()
				
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "I":
				var item = FROZEN.instantiate()
				
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
	#check if player near key
	for i in range(len(Global.map)):
		for j in range(len(Global.map[i])):
			if Global.map[i][j] == "K":
				if i > 0:
					if Global.map[i-1][j] == "P":
						Global.map[i][j] = "E"
						Global.keys += 1
				if j > 0:
					if Global.map[i][j+1] == "P":
						Global.map[i][j] = "E"
						Global.keys += 1
				if j < len(Global.map[i])-1:
					if Global.map[i][j-1] == "P":
						Global.map[i][j] = "E"
						Global.keys += 1
				if i < len(Global.map):
					if Global.map[i+1][j] == "P":
						Global.map[i][j] = "E"
						Global.keys += 1
			if Global.map[i][j] == "F":
				if i > 0:
					if Global.map[i-1][j] == "P":
						if Global.keys == Global.key_count:
							Global.keys = 0
							Global.reset_rules()
							get_tree().change_scene_to_file("res://scenes/map_selector.tscn")
				if j > 0:
					if Global.map[i][j+1] == "P":
						if Global.keys == Global.key_count:
							Global.keys = 0
							Global.reset_rules()
							get_tree().change_scene_to_file("res://scenes/map_selector.tscn")
				if j < len(Global.map[i])-1:
					if Global.map[i][j-1] == "P":
						if Global.keys == Global.key_count:
							Global.keys = 0
							Global.reset_rules()
							get_tree().change_scene_to_file("res://scenes/map_selector.tscn")
				if i < len(Global.map):
					if Global.map[i+1][j] == "P":
						if Global.keys == Global.key_count:
							Global.keys = 0
							Global.reset_rules()
							get_tree().change_scene_to_file("res://scenes/map_selector.tscn")
			if Global.map[i][j] == "X":
				var flag = false
				if i > 0 and j > 0 and j < len(Global.map[i])-1 and i < len(Global.map):
					for k in range(-1,2):
						for l in range(-1,2):
							if Global.map[i+k][j+l] == "I":
								Global.map[i+k][j+l] = "X"
								flag = true
				if flag:
					create_map()
							


func _on_h_slider_value_changed(value):
	Global.speed = 1.0-value
	map_timer.wait_time = 1.0-value
	
	var label_text = str(int(value*100))
	if len(label_text) == 1:
		label.text = "  " + label_text
	else:
		label.text = label_text

func get_key_count():
	Global.key_count = 0
	for i in range(len(Global.map)):
		for j in range(len(Global.map[i])):
			if Global.map[i][j] == "K":
				Global.key_count += 1
