extends Node2D

var is_menu_visible = false
@onready var canvas_layer = $"../CanvasLayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		visible = !is_menu_visible
		canvas_layer.visible = is_menu_visible
		is_menu_visible = !is_menu_visible
