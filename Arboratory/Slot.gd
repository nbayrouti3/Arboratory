extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var InventoryItemClass = preload("res://InventoryItem.tscn")
var inventory_item = null
var tree_appearance
onready var tree_counter
func _ready():
	rect_min_size = Vector2(60,60)
	
func _add_inventory_item():
	inventory_item = InventoryItemClass.instance()
	inventory_item.tree_number = tree_counter
	add_child(inventory_item)
	
	print("treecounter: " + str(tree_counter))
	tree_appearance = inventory_item.tree_appearance
	print("treecounter: " + str(tree_counter))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _remove_inventory_item():
	remove_child(inventory_item)
	#var inventoryNode = find_parent("Inventory")
	#inventoryNode.add_child(inventory_item)
	inventory_item = null
