extends Node2D


@onready var canvas_layer = $"../../CanvasLayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		visible = !Global.is_create_menu_visible
		canvas_layer.visible = Global.is_create_menu_visible
		Global.is_create_menu_visible = !Global.is_create_menu_visible
