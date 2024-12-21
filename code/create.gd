extends Node2D
const ITEM = preload("res://prefabs/mapItem.tscn")
const DARK = preload("res://img/dark.png")
const ORANGE = preload("res://img/orange.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var dummy = ITEM.instantiate()
	var sprite = dummy.get_child(0)
	dummy.queue_free()
	
	for i in range(len(Global.map)):
		for j in range(len(Global.map[i])):
			if Global.map[i][j] == "E":
				var item = ITEM.instantiate()
				item.add_to_group(str(i)+ " " + str(j))
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)
			elif Global.map[i][j] == "S":
				var item = ITEM.instantiate()
				item.get_child(0).texture = ORANGE
				item.add_to_group(str(i)+ " " + str(j))
				item.position += Vector2(sprite.get_rect().size.x * sprite.scale.x * j,sprite.get_rect().size.y * sprite.scale.x * i)
				add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
