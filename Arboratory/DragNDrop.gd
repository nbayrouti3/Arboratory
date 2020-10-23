extends Area2D
#A very gross script the further you go down.

"""
Declaring a lot of variables
"""
onready var pot = get_tree().get_root().find_node("Pot", true, false)
onready var Seeds = get_tree().get_root().find_node("Seeds", true, false).get_children()
onready var dragNode = get_parent()
onready var Slots = get_tree().get_root().find_node("BaseFarmGrid",true,false).get_node("Inventory/GridContainer").get_children()

signal clicked
signal planted
signal watered
signal unlocked
signal add_to_inventory
signal remove_from_inventory

var previous_mouse_position = Vector2()
var is_dragging = false
var seeded = false
var planted = 0
var is_new_seed = false

func _ready():
	pot.connect("seeded",self,"changeSeed")
	#for See in Seeds:
		#See.connect("planted",self,"planted")
	for Slot in Slots:
		Slot.connect("add_seed",self,"_revert_seed")
	#print("new seed: " + str(is_new_seed))
		
	

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

#func planted():
#	print("Planted Function was Run")
	#if planted % 2 == 0:
	#	seeded = true
	#else:
	#	seeded = false
	#print(seeded)
	#planted += 1

"""
The change seed function gets a signal when a pot is both watered and planted.
It then will find the seed location in the dictionary and change the art.
"""

func changeSeed(which):
	var seedData = ImportData.seed_data
	for key in seedData:
		if seedData[key]["seedImage"] == which.get_node("SeedImage").texture:
			which.get_node("SeedImage").texture = load(seedData[key]["saplingImage"])
			print(self)
			emit_signal("unlocked", key)
			emit_signal("add_to_inventory","sapling",key)
		
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
		
#func _revert_seed(aSeed,which):
func _revert_seed(aSeed,which):
	aSeed.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/"+which+"_seed.png")
	emit_signal("remove_from_inventory")
	
#func _connect_newSeed(newSeed):
	#newSeed.connect("area_shape_entered",self,"_on_aSeeds_area_shape_entered")
	#newSeed.connect("area_shape_exited",self,"_on_aSeeds_area_shape_exited")
	
	
