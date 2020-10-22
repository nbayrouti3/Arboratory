extends Node2D

signal close_menu

#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
	$Seeds.get_node("aSeeds2").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/seed-laventree.png")
	$Seeds.get_node("aSeeds3").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
	$Seeds.get_node("aSeeds4").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/Lighting_seed.png")
	$Seeds.get_node("aSeeds5").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/Sand_Seed.png")
	$Seeds.get_node("aSeeds6").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/air_seed.png")
	$Seeds.get_node("aSeeds7").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/cottonCandy_Seed.png")
	$Seeds.get_node("aSeeds8").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/earth_seed.png")
	$Seeds.get_node("aSeeds9").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/fire_seed.png")
	$Seeds.get_node("aSeeds10").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/magma_seed.png")
	$Seeds.get_node("aSeeds11").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
	$Seeds.get_node("aSeeds12").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/water_seed.png")
	$FarmButton.set_position(Vector2(0,50))
	$FarmButton.set_text("Farm")
	pass 



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
	$Seeds.hide()
	

func _return_to_planting():
	$Pot.show()
	$"Lab Bench".show()
	$water.show()
	$Seeds.show()
	$BaseFarmGrid._pause()
	$BaseFarmGrid/PlantingNotifier/ClearSinglePlot.hide()
	$BaseFarmGrid/PlantingNotifier/Return.hide()
	$BaseFarmGrid/PlantingNotifier/Water.hide()
	$BaseFarmGrid/Farm._close_menu()
