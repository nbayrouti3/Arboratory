extends Area2D
#A very gross script the further you go down.

"""
Declaring a lot of variables
"""
onready var pot = get_tree().get_root().find_node("Pot", true, false)
onready var Seeds = get_tree().get_root().find_node("Seeds", true, false).get_children()
onready var dragNode = get_parent()

signal clicked
signal planted
signal watered
var previous_mouse_position = Vector2()
var is_dragging = false
var seeded = false
var planted = 0


func _ready():
	pot.connect("seeded",self,"changeSeed")
	for See in Seeds:
		See.connect("planted",self,"planted")


"""
When a seed enters a shape it checks if its a pot
If it is it tells the Merge Area Script its been planted
When it is removed it tells it that its gone
The watered function starts the growth process.
"""
func _on_aSeeds_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		position = Vector2(518,220)
		is_dragging = false
		emit_signal("planted",self)


func _on_aSeeds_area_shape_exited(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		emit_signal("planted",self)

func _on_water_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		position = Vector2(960,62)
		emit_signal("watered")
		is_dragging = false

"""
Can't remember exactly how this works I did this at 4am so I will be back
"""

func planted():
	print("Planted Function was Run")
	if planted % 2 == 0:
		seeded = true
	else:
		seeded = false
	print(seeded)
	planted += 1

"""
The change seed function gets a signal when a pot is both watered and planted.
It then will find the seed location in the dictionary and change the art.
"""

func changeSeed(which):
	var seedData = ImportData.seed_data
	for key in seedData:
		if seedData[str(key)]["seedImage"] == which.get_node("SeedImage").texture:
			which.get_node("SeedImage").texture = load(seedData[key]["sapplingImage"])
		
"""
When clicked on,
can be moved around the screen
"""

func _on_draggable_input_event(viewport, event, shape_idx):
	
	"""
	Allows dragging if the user clicks inside
	the collision shape
	"""
	
	if event.is_action_pressed("ui_touch"):
		print(event)
		get_tree().set_input_as_handled()
		previous_mouse_position = event.position
		is_dragging = true
		emit_signal("clicked")


func _input(event):
	
	"""
	Works globally so dragging works if
	mouse cursor is outside of Collision Shape
	Disables dragging if the user releases click
	"""
	
	if not is_dragging:
		return
	
	if event.is_action_released("ui_touch"):
		previous_mouse_position = Vector2()
		is_dragging = false
	
	
	if is_dragging and event is InputEventMouseMotion:
		position += event.position - previous_mouse_position
		previous_mouse_position = event.position



"""
Here is the Godot Dictionary for all the seed image and locations. (Temporary Location)
"""

"""
var seedData = {
	"1" : {
		"seedImage" : preload("res://Assets/Plants/seeds/SampleSeed.png"),
		"sapplingImage" : "res://Assets/Art/SamplePlant.png",
		"treeImage" : "",
		"Description": ""
	},
	"2" : {
		"seedImage" : preload("res://Assets/Plants/seeds/seed-laventree.png"),
		"sapplingImage" : "res://Assets/Plants/trees/laventree_owo.png",
		"treeImage" : ""
		},
	"3": {
		"seedImage" : preload("res://Assets/Art/Sample Water.png"),
		"sapplingImage" : "",
		"treeImage" : ""
		}
}

"""

