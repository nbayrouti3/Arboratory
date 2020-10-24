extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal add_seed

# Called when the node enters the scene tree for the first time.
var InventoryItemClass = preload("res://InventoryItem.tscn")
var inventory_item = null
var tree_appearance
onready var tree_counter
func _ready():
	rect_min_size = Vector2(60,60)
	
func _add_inventory_item(type, inventory_item_name):
	if type == "sapling":
		inventory_item = InventoryItemClass.instance()
		inventory_item.tree_number = inventory_item_name
		add_child(inventory_item)
	elif type == "seed":
		inventory_item = InventoryItemClass.instance()
		inventory_item.item_name = inventory_item_name
		add_child(inventory_item)
		if inventory_item_name == "air":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds6"),"air")
		elif inventory_item_name == "water":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds12"),"water")
		elif inventory_item_name == "earth":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds8"),"earth")
		elif inventory_item_name == "fire":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds9"),"fire")
		elif inventory_item_name == "magma":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds10"),"magma")
		elif inventory_item_name == "snoop":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds11"),"snoop_dogg")
		elif inventory_item_name == "cottoncandy":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds7"),"cotton_candy")
		elif inventory_item_name == "lightning":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds4"),"lightning")
		elif inventory_item_name == "bunny":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds3"),"bunny")
		elif inventory_item_name == "sand":
			emit_signal("add_seed",get_tree().get_root().find_node("Seeds",true,false).get_node("aSeeds5"),"sand")
			
	else:
		print("cannot be added")
	
	
	tree_appearance = inventory_item.tree_appearance
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _remove_inventory_item():
	remove_child(inventory_item)
	#var inventoryNode = find_parent("Inventory")
	#inventoryNode.add_child(inventory_item)
	inventory_item = null
