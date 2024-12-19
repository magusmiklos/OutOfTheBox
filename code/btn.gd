extends Sprite2D

const GRAY = preload("res://img/gray.png")
const DARK = preload("res://img/dark.png")
const PINK = preload("res://img/pink.png")

var is_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Global.start:
		return
	
	if Input.is_action_just_pressed("click"):
		var inds = get_parent().get_groups()[0].split(" ")
		
		#print(inds)
		#print(Global.to)
		
		
		
		if is_on:
			self.texture = GRAY
			
			if inds[1] == "1":
				Global.to[int(inds[0])][int(inds[2])][int(inds[3])] = "E"
			else:
				Global.from[int(inds[0])][int(inds[2])][int(inds[3])] = "E"
		else:
			if Global.is_chaos_selected:
				self.texture = DARK
			else:
				
				#ensure that player P is only apears at most once in any subrule
				if inds[1] == "1":
					var player_count = 0
					for i in Global.to[int(inds[0])]:
						for j in i:
							if j == "P":
								player_count += 1
					if player_count > 0:
						return
				
				else:
					var player_count = 0
					for i in Global.from[int(inds[0])]:
						for j in i:
							if j == "P":
								player_count += 1
					if player_count > 0:
						return
								
				self.texture = PINK
			
			if inds[1] == "1":
				if Global.is_chaos_selected:
					Global.to[int(inds[0])][int(inds[2])][int(inds[3])] = "X"
				else:
					Global.to[int(inds[0])][int(inds[2])][int(inds[3])] = "P"
			else:
				if Global.is_chaos_selected:
					Global.from[int(inds[0])][int(inds[2])][int(inds[3])] = "X"
				else:
					Global.from[int(inds[0])][int(inds[2])][int(inds[3])] = "P"
				
		is_on = !is_on
