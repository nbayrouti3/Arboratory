extends Area2D
#A very gross script the further you go down.

"""
Declaring a lot of variables
"""

signal clicked
signal planted
signal watered
var previous_mouse_position = Vector2()
var is_dragging = false


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

"""
func _on_aSeeds_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		position = Vector2(518,220)
		is_dragging = false
		emit_signal("planted")


func _on_aSeeds_area_shape_exited(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		emit_signal("planted")

func _on_water_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		position = Vector2(960,62)
		emit_signal("watered")
		is_dragging = false



"""

"""


onready var pot = get_tree().get_root().find_node("Pot", true, false)
onready var Seed = get_tree().get_root().find_node("aSeeds", true, false)
onready var dragNode = get_parent()

var seeded = false
var planted = 0

func _ready():
	Seed.connect("planted",self,"planted")
	pot.connect("seeded",self,"changeSeed")
	#print(seedData[01]["seedImage"])
	#print(seedData[02]["seedImage"])
	#print(texture)
	#if texture == seedData[01]["seedImage"]:
	#	print("This works")
	pass
	#dragNode.connect("clicked",self,"changeSeed")
	#dragNode.position = Vector2(518,220)

func planted():
	print("Planted Function was Run")
	if planted % 2 == 0:
		seeded = true
	else:
		seeded = false
	print(seeded)
	planted += 1

func changeSeed():
	for key in seedData:
		print(key)
		if seedData[key]["seedImage"] == Seed.get_node("SeedImage").texture:
			if seeded:
				Seed.get_node("SeedImage").texture = load(seedData[key]["sapplingImage"])
		

var seedData = {
	01 : {
		"seedImage" : preload("res://Assets/Plants/seeds/SampleSeed.png"),
		"sapplingImage" : "res://Assets/Art/SamplePlant.png",
		"treeImage" : "",
		"Description": ""
	},
	02 : {
		"seedImage" : preload("res://Assets/Plants/seeds/seed-laventree.png"),
		"sapplingImage" : "res://Assets/Plants/trees/laventree_owo.png",
		"treeImage" : ""
		},
	03: {
		"seedImage" : preload("res://Assets/Art/Sample Water.png"),
		"sapplingImage" : "",
		"treeImage" : ""
		}
}


