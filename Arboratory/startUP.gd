extends Node2D

signal close_menu

var seed_pos = Vector2(77,100)
#var SeedClass = preload("res://aSeeds.tscn")
#var script1 = preload("res://mergeArea.gd")
#var instance = script1.new()

#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
	$Seeds.get_node("aSeeds2").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/seed-laventree.png")
	$Seeds.get_node("aSeeds3").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
	#$Seeds.get_node("aSeeds4").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/lightning_seed.png")
	#$Seeds.get_node("aSeeds5").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/sand_seed.png")
	$Seeds.get_node("aSeeds6").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/air_seed.png")
	$Seeds.get_node("aSeeds7").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/cotton_candy_seed.png")
	$Seeds.get_node("aSeeds8").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/earth_seed.png")
	$Seeds.get_node("aSeeds9").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/fire_seed.png")
	#$Seeds.get_node("aSeeds10").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/magma_seed.png")
	$Seeds.get_node("aSeeds11").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
	$Seeds.get_node("aSeeds12").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/water_seed.png")
	$FarmButton.set_position(Vector2(0,50))
	$FarmButton.set_text("Farm")
	pass 

func _new_seed(type, number):
	for x in range(number):
		var seedling = load("res://aSeeds.tscn").instance()
		seedling.connect("planted",$Pot,"planted")
		add_child(seedling)
		seedling.add_to_group("seedGroup")
		get_tree().call_group("seedGroup","hide")
		match (type):
			"bunny":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
			"lightning":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/lightning_seed.png")
			"air":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/air_seed.png")
			"cottoncandy":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/cotton_candy_seed.png")
			"earth":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/earth_seed.png")
			"fire":
			#$Seeds.get_node("newSeed").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/fire_seed.png")
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/fire_seed.png")
			"magma":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/magma_seed.png")
			"snoop":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
			"water":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/water_seed.png")
			"sand":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/sand_seed.png")
		
		seedling.set_position(Vector2(77,500))
		seedling.is_old_seed = false
		seedling.max_seeds = true
		
		
		#newSeed.is_new_seed = true
		#print("new seed: " + str(newSeed.is_new_seed))
		#newSeed._connect_newSeed(newSeed)
		

func _on_treeDex_button_pressed():
	$treeDex.show()
	get_tree().paused = true


func _on_FarmButton_pressed():
	$BaseFarmGrid._unpause()
	$BaseFarmGrid/Inventory/ColorRect.show()
	$BaseFarmGrid/Inventory/GridContainer.show()
	$BaseFarmGrid/Farm.show()
	$BaseFarmGrid/PlantingNotifier/ClearPlots.show()
	$BaseFarmGrid/PlantingNotifier/ExitFarm.show()
	$BaseFarmGrid/PlantingNotifier/PlantingNotifierMessage.show()
	$Pot.hide()
	$water.hide()
	$"Lab Bench".hide()
	get_tree().call_group("seedGroup","hide")
	

func _return_to_planting():
	$Pot.show()
	$"Lab Bench".show()
	$water.show()
	get_tree().call_group("seedGroup","show")
	$BaseFarmGrid._pause()
	$BaseFarmGrid/PlantingNotifier/ClearSinglePlot.hide()
	$BaseFarmGrid/PlantingNotifier/Return.hide()
	$BaseFarmGrid/PlantingNotifier/Water.hide()
	$BaseFarmGrid/Farm._close_menu()
