extends Control

onready var seedData = ImportData.seed_data
var key = 1

func _ready():
	load_tree()
	
	
	
func _on_exit_button_pressed():
	self.visible = false
	get_tree().paused = false


func _on_back_button_pressed():
	if(key == 1):
		pass
	else:
		key -= 1
	load_tree()


func _on_next_button_pressed():
	if(key == 4):
		pass
	else:
		key += 1
	load_tree()

func load_tree():
	$tree_id.text = str(key)
	$Tree_Art.texture = load(seedData[str(key)]["sapplingImage"])
	$tree_name.text = seedData[str(key)]["treeName"]
	$tree_description.text = seedData[str(key)]["Description"]
	$tree_properties.text = "Coming Soon"
