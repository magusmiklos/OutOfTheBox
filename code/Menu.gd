extends Node2D

@onready var menu = $"."
@onready var back = $"../../Back"
@onready var button = $MarginContainer/VBoxContainer/Button

const ARROW = preload("res://prefabs/arrow.tscn")
const ITEM_BTN = preload("res://prefabs/itemBtn.tscn")
@onready var map = $"../../Map"

# Called when the node enters the scene tree for the first time.
func _ready():
	for rule in range(-1,2):
		var ar = ARROW.instantiate()
		ar.position = Vector2(400*rule,-155)
		add_child(ar)
		for sub_rule in range(2):
			for i in range(3):
				for j in range(3):
					var item = ITEM_BTN.instantiate()
					item.apply_scale(Vector2(1.5,1.5))
					item.position = Vector2(j*45+400*rule + sub_rule*200 -145,i*45-200)
					item.add_to_group(str(rule+1)+" "+str(sub_rule)+" "+str(i)+" "+str(j))
					add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if Global.start == false:
		Global.start = true

		button.text = "Restart"
	else:
		Global.keys = 0
		Global.start = false
		Global.map = Global.maps[Global.current_map].duplicate()
		button.text = "Start"
		map.create_map()
		#add map again so destroy and add it back again
	menu.visible = false
	back.get_material().set_shader_parameter("speed",1)

#exit
func _on_button_2_pressed():
	Global.keys = 0
	Global.reset_rules()
	get_tree().change_scene_to_file("res://scenes/map_selector.tscn")
