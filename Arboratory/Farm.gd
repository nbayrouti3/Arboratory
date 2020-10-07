extends TileMap

signal plot_clicked

var tile_size = get_cell_size()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var farm_size = Vector2(10,10)
var farm = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(farm_size.x):
		farm.append([])
		for y in range(farm_size.y):
			farm[x].append(null)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if Input.is_action_pressed("ui_click"):
		#print("Mouse Click at: ",event.position)
		var spot = "Tree planted in plot: " + str(int((event.position.x-80)/(64*.75))) + "," + str(int((event.position.y-40)/(64*.75)))
		#print(int(event.position.x/64))
		emit_signal("plot_clicked",spot)
