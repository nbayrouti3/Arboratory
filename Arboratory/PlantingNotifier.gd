extends CanvasLayer

signal plant_fire
signal plant_water
signal plant_air
signal plant_magma
signal plant_earth
signal clear
signal clear_single


# Called when the node enters the scene tree for the first time.
func _ready():
	$WaterTree.set_position(Vector2(900,40))
	$FireTree.set_position(Vector2(900,100))
	$EarthTree.set_position(Vector2(900,160))
	$AirTree.set_position(Vector2(900,220))
	$MagmaTree.set_position(Vector2(900,280))
	$ClearPlots.set_position(Vector2(900,340))
	$ClearSinglePlot.set_position(Vector2(900,400))
	show_message("New Farm")
	$PlantingNotifierMessage.set_position(Vector2(1100,600))
	
#updates the planting message
func show_message(text):
	$PlantingNotifierMessage.text = text
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#choosing a water tree
func _on_WaterTree_pressed():
	$WaterTree.show()
	$FireTree.show()
	$MagmaTree.show()
	$AirTree.show()
	$EarthTree.show()
	emit_signal("plant_water","water_tree")

#choosing a fire tree
func _on_FireTree_pressed():
	$FireTree.show()
	$WaterTree.show()
	$MagmaTree.show()
	$AirTree.show()
	$EarthTree.show()
	emit_signal("plant_fire","fire_tree")

#choosing an earth tree
func _on_EarthTree_pressed():
	$EarthTree.show()
	$WaterTree.show()
	$FireTree.show()
	$MagmaTree.show()
	$AirTree.show()
	emit_signal("plant_earth","earth_tree")
	

#choosing an air tree
func _on_AirTree_pressed():
	$AirTree.show()
	$EarthTree.show()
	$WaterTree.show()
	$FireTree.show()
	$MagmaTree.show()
	emit_signal("plant_air","air_tree")

#choosing a magma tree
func _on_MagmaTree_pressed():
	$MagmaTree.show()
	$AirTree.show()
	$EarthTree.show()
	$WaterTree.show()
	$FireTree.show()
	emit_signal("plant_magma","magma_tree")

#clear all plots
func _on_ClearPlots_pressed():
	emit_signal("clear")

#clear single plot
func _on_ClearSinglePlot_pressed():
	emit_signal("clear_single")
