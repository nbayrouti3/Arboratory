extends Node2D
onready var farm = get_parent()

func _ready():
	pass

func _draw():
	var LINE_COLOR = Color(255, 255, 255)
	var LINE_WIDTH = 2
	

	for x in range(farm.farm_size.x + 1):
		var col_pos = x * farm.tile_size.x
		var limit = farm.farm_size.y * farm.tile_size.y
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, limit), LINE_COLOR, LINE_WIDTH)
	for y in range(farm.farm_size.y + 1):
		var row_pos = y * farm.tile_size.y
		var limit = farm.farm_size.x * farm.tile_size.x
		draw_line(Vector2(0, row_pos), Vector2(limit, row_pos), LINE_COLOR, LINE_WIDTH)
