extends Control

# Define the two points
var point_a = null
var point_b = null

func _process(delta):
	if Input.is_action_just_pressed("rightclick"):
		point_a = get_global_mouse_position()
	elif Input.is_action_pressed("rightclick"):
		point_b = get_global_mouse_position()
		queue_redraw()
	elif Input.is_action_just_released("rightclick"):
		point_a = null
		point_b = null
		queue_redraw() # Ensure the screen is cleared by triggering a redraw

func _draw():
	if point_a and point_b and !Global.is_create_menu_visible and Global.editor_motions:
		# Calculate the top-left corner of the rectangle
		var top_left: Vector2 = Vector2(min(point_a.x, point_b.x), min(point_a.y, point_b.y))
		# Calculate the size of the rectangle
		var size: Vector2 = Vector2(abs(point_a.x - point_b.x), abs(point_a.y - point_b.y))
		# Draw the rectangle
		draw_rect(Rect2(top_left, size), Color(0, 0, 0, 0.5)) # Color can be changed as needed
