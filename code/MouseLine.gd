extends Control

# Define the two points
var point_a = null
var point_b = null

func _process(delta):
	if Input.is_action_just_pressed("click"):
		point_a = Global.editor_cursor
	elif Input.is_action_pressed("click"):
		point_b = get_global_mouse_position()
		queue_redraw()
	elif Input.is_action_just_released("click"):
		point_a = null
		point_b = null
		queue_redraw() # Ensure the screen is cleared by triggering a redraw

func _draw():
	if point_a and point_b and !Global.is_create_menu_visible and Global.editor_motions:
		draw_line(point_a, point_b, Color(0.48, 0.16, 0.8), 10)
