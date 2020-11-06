extends Node2D

"""
Variables to store the number of each seed created
"""
var bunny_num = 0
var lightning_num = 0
var sand_num = 0
var air_num = 0
var cottoncandy_num = 0
var earth_num = 0
var fire_num = 0
var magma_num = 0
var snoop_num = 0
var water_num = 0
var bubble_num = 0
var tree_num = 0

"""
Not sure what the comments are here but puts the air, fire, water, earth seed 
into the game.
"""
#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
	_new_seed("air",1)
	_new_seed("water",1)
	_new_seed("earth",1)
	_new_seed("fire",1)
	get_tree().call_group("seedGroup","show")
	pass 

"""
Adds a new seed into the merging area. Pass in the type of seed and the number
to be added.
A new seed is an aSeeds instance and is connected to the Pot. It is also added 
into the seedGroup, given its texture, its name, and assigned a spot on the screen.
BaseFarmGrid will call this also to add seeds.
"""
func _new_seed(type, number):
	for x in range(number):
		var seedling = load("res://aSeeds.tscn").instance()
		
		seedling.seed_name = type
		seedling.connect("planted",$Pot,"planted")
		add_child(seedling)
		seedling.add_to_group("seedGroup")
		#get_tree().call_group("seedGroup","hide")
		match (type):
			"bunny":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
				if bunny_num %2 == 0:
					seedling.set_position(Vector2(77,600))
					seedling.seed_pos = Vector2(77,600)
				else:
					seedling.set_position(Vector2(77,700))
					seedling.seed_pos = Vector2(77,700)
				bunny_num+=1
			"lightning":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/lightning_seed.png")
				if lightning_num %2 == 0:
					seedling.set_position(Vector2(177,600))
					seedling.seed_pos = Vector2(177,600)
				else:
					seedling.set_position(Vector2(177,700))
					seedling.seed_pos = Vector2(177,700)
				lightning_num+=1
			"air":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/air_seed.png")
				if air_num %2 == 0:
					seedling.set_position(Vector2(277,600))
					seedling.seed_pos = Vector2(277,600)
				else:
					seedling.set_position(Vector2(277,700))
					seedling.seed_pos = Vector2(277,700)
				air_num+=1
			"cottoncandy":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/cotton_candy_seed.png")
				if cottoncandy_num %2 == 0:
					seedling.set_position(Vector2(377,600))
					seedling.seed_pos = Vector2(377,600)
				else:
					seedling.set_position(Vector2(377,700))
					seedling.seed_pos = Vector2(377,700)
				cottoncandy_num+=1
			"earth":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/earth_seed.png")
				if earth_num %2 == 0:
					seedling.set_position(Vector2(477,600))
					seedling.seed_pos = Vector2(477,600)
				else:
					seedling.set_position(Vector2(477,700))
					seedling.seed_pos = Vector2(477,700)
				earth_num+=1
			"fire":
			#$Seeds.get_node("newSeed").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/fire_seed.png")
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/fire_seed.png")
				if fire_num %2 == 0:
					seedling.set_position(Vector2(577,600))
					seedling.seed_pos = Vector2(577,600)
				else:
					seedling.set_position(Vector2(577,700))
					seedling.seed_pos = Vector2(577,700)
				fire_num+=1
			"magma":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/magma_seed.png")
				if magma_num %2 == 0:
					seedling.set_position(Vector2(677,600))
					seedling.seed_pos = Vector2(677,600)
				else:
					seedling.set_position(Vector2(677,700))
					seedling.seed_pos = Vector2(677,700)
				magma_num+=1
			"snoop":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
				if snoop_num %2 == 0:
					seedling.set_position(Vector2(777,600))
					seedling.seed_pos = Vector2(777,600)
				else:
					seedling.set_position(Vector2(777,700))
					seedling.seed_pos = Vector2(777,700)
				snoop_num+=1
			"water":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/water_seed.png")
				if water_num %2 == 0:
					seedling.set_position(Vector2(877,600))
					seedling.seed_pos = Vector2(877,600)
				else:
					seedling.set_position(Vector2(877,700))
					seedling.seed_pos = Vector2(877,700)
				water_num+=1
			"sand":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/sand_seed.png")
				if sand_num %2 == 0:
					seedling.set_position(Vector2(977,600))
					seedling.seed_pos = Vector2(977,600)
				else:
					seedling.set_position(Vector2(977,700))
					seedling.seed_pos = Vector2(977,700)
				sand_num+=1
			"bubble":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/bubble_seed.png")
				if bubble_num %2 == 0:
					seedling.set_position(Vector2(1077,600))
					seedling.seed_pos = Vector2(1077,600)
				else:
					seedling.set_position(Vector2(1077,700))
					seedling.seed_pos = Vector2(1077,700)
				bubble_num+=1
			"tree":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/tree_seed.png")
				if tree_num%2 == 0:
					seedling.set_position(Vector2(1177,600))
					seedling.seed_pos = Vector2(1177,600)
				else:
					seedling.set_position(Vector2(1177,700))
					seedling.seed_pos = Vector2(1177,700)
				tree_num+=1
		seedling.hide()


			
		
"""
Shows the dex and pauses the rest of the game when the dex button is pressed.
"""
		

func _on_treeDex_button_pressed():
	$treeDex.show()
	get_tree().call_group("seedGroup","hide")
	get_tree().paused = true

"""
Switches scenes to the BaseFarmGrid when the farm button is pressed, 
pausing (sort of) the rest of the game and unpausing the farm.
Shows the Farm and Inventory and hides the rest.
"""
func _on_FarmButton_pressed():
	$BaseFarmGrid._unpause()
	$BaseFarmGrid/Inventory/ColorRect.show()
	$BaseFarmGrid/Inventory/GridContainer.show()
	$BaseFarmGrid/Farm.show()
	$BaseFarmGrid/PlantingNotifier/ClearPlots.show()
	$BaseFarmGrid/PlantingNotifier/ExitFarm.show()
	$BaseFarmGrid/PlantingNotifier/PlantingNotifierMessage.show()
	$BaseFarmGrid/PlantingNotifier/ProgressBar.show()
	$Pot.hide()
	$water.hide()
	$treeDex_button.set_position(Vector2(900,700))
	$FarmButton.hide()
	get_tree().call_group("seedGroup","hide")
	
"""
Returns to the merge area from the BaseFarmGrid when the return button is pressed,
unpausing (sort of) the rest of the game and pausing the farm.
Shows seeds and pot and hides Farm and Inventory.
Makes sure to close any open tree menu
"""
func _return_to_planting():
	$Pot.show()
	$water.show()
	$treeDex_button.set_position(Vector2(373,15))
	$FarmButton.show()
	get_tree().call_group("seedGroup","show")
	$BaseFarmGrid._pause()
	$BaseFarmGrid/PlantingNotifier/ClearSinglePlot.hide()
	$BaseFarmGrid/PlantingNotifier/Return.hide()
	$BaseFarmGrid/PlantingNotifier/Water.hide()
	$BaseFarmGrid/PlantingNotifier/ProgressBar.hide()
	$BaseFarmGrid/Farm._close_menu()
