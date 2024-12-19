extends Sprite2D

const PINK = preload("res://img/pink.png")
const DARK = preload("res://img/dark.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):	
	if Input.is_action_just_pressed("click"):
		if Global.is_chaos_selected:
			self.texture = PINK
		else:
			self.texture = DARK
		Global.is_chaos_selected = !Global.is_chaos_selected
