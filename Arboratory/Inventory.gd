extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TreeItemClass = preload("res://Tree.tscn")
const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $GridContainer
var last_slot_clicked
onready var Water = get_tree().get_root().find_node("water",true,false)
#var tree_type = null

signal air_tree_pressed
signal earth_tree_pressed
signal fire_tree_pressed
signal magma_tree_pressed
signal snoop_tree_pressed
signal water_tree_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = Color(0,.960784,1,1)
	$ColorRect.set_size(Vector2(400,250))
	$ColorRect.set_position(Vector2(1200,200))
	$GridContainer.set_position(Vector2(1205,250))
	$GridContainer.columns = 6
	$GridContainer.set("custom_constants/vseparation",6)
	$GridContainer.set("custom_constants/hseparation",6) 
	Water.connect("add_to_inventory",self, "_add_to_inventory")

	for inv_slot in inventory_slots.get_children():
		inv_slot.color = Color(.478431,.505882,.501961,1)
		inv_slot.connect("gui_input",self,"slot_gui_input",[inv_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			#if !slot.inventory_item:
				#slot._add_inventory_item()
			
			#else:
			for inv_slot in inventory_slots.get_children():
				inv_slot.color = Color(.478431,.505882,.501961,1)
			slot.color = Color(0,1,0,1)
			
			if slot.tree_appearance == "air_sapling" && slot.inventory_item:
				emit_signal("air_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "earth_sapling" && slot.inventory_item:
				emit_signal("earth_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "fire_sapling"&& slot.inventory_item:
				emit_signal("fire_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "magma_sapling"&& slot.inventory_item:
				emit_signal("magma_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "snoop_sapling"&& slot.inventory_item:
				emit_signal("snoop_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "water_sapling"&& slot.inventory_item:
				emit_signal("water_tree_pressed")
				#slot._remove_inventory_item()
			else:
				print("not ready")
			last_slot_clicked = slot
			#print(last_slot_clicked)

func _add_to_inventory(type, inventory_item_name):
	for inv_slot in inventory_slots.get_children():
		if !inv_slot.inventory_item:
<<<<<<< HEAD
			inv_slot._add_inventory_item(type, inventory_item_name)
=======
			print("add_inventory: " + inventory_item_name)
			inv_slot._add_inventory_item("seed", inventory_item_name)
>>>>>>> master
			break

func _remove_from_inventory():
	last_slot_clicked._remove_inventory_item()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _input(event):
	#if event.is_action_pressed("ui_click"):
		#if tree_type != null:
			#var tree = TreeItemClass.instance()
			#add_child(tree)
			#tree._choose_tree(tree_type)
			#tree.set_position(Vector2(event.position.x,event.position.y))
			#tree_type = null
