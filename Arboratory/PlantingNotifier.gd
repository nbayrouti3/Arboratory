extends CanvasLayer

signal plant_fire
signal plant_water
signal plant_air
signal plant_magma
signal plant_earth
signal plant_snoop
signal clear
signal clear_single
signal water_tree
signal close_menu


# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/Lato-Regular.ttf")
	dynamic_font.size = 43
	#$WaterTree.set_position(Vector2(900,40))
	#$WaterTree.add_font_override("font",dynamic_font)
	#$FireTree.set_position(Vector2(900,100))
	#$FireTree.add_font_override("font",dynamic_font)
	#$EarthTree.set_position(Vector2(900,160))
	#$EarthTree.add_font_override("font",dynamic_font)
	#$AirTree.set_position(Vector2(900,220))
	#$AirTree.add_font_override("font",dynamic_font)
	#$MagmaTree.set_position(Vector2(900,280))
	#$MagmaTree.add_font_override("font",dynamic_font)
	#$SnoopTree.set_position(Vector2(900,340))
	#$SnoopTree.add_font_override("font",dynamic_font)
	$WaterTree.hide()
	$FireTree.hide()
	$EarthTree.hide()
	$AirTree.hide()
	$MagmaTree.hide()
	$SnoopTree.hide()
	$ClearPlots.set_position(Vector2(900,400))
	$ClearPlots.add_font_override("font",dynamic_font)
	$ClearSinglePlot.set_position(Vector2(900,460))
	$ClearSinglePlot.add_font_override("font",dynamic_font)
	$ClearSinglePlot.hide()
	$PlantingNotifierMessage.set_position(Vector2(1100,600))
	$PlantingNotifierMessage.add_font_override("font",dynamic_font)
	$Return.set_position(Vector2(900,520))
	$Return.add_font_override("font",dynamic_font)
	$Return.hide()
	$Water.set_position(Vector2(900,280))
	$Water.add_font_override("font",dynamic_font)
	$Water.hide()
	show_message("New Farm")
	
#updates the planting message
func show_message(text):
	$PlantingNotifierMessage.text = text
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#choosing a water tree
func _on_WaterTree_pressed():
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	emit_signal("plant_water","water_tree")

#choosing a fire tree
func _on_FireTree_pressed():
	#$FireTree.show()
	#$WaterTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	emit_signal("plant_fire","fire_tree")

#choosing an earth tree
func _on_EarthTree_pressed():
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	emit_signal("plant_earth","earth_tree")
	

#choosing an air tree
func _on_AirTree_pressed():
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	emit_signal("plant_air","air_tree")

#choosing a magma tree
func _on_MagmaTree_pressed():
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	emit_signal("plant_magma","magma_tree")
	
func _on_SnoopTree_pressed():
	#$AirTree.show()
	#$MagmaTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	emit_signal("plant_snoop","snoop_tree")

#clear all plots
func _on_ClearPlots_pressed():
	emit_signal("clear")

#clear single plot
func _on_ClearSinglePlot_pressed():
	emit_signal("clear_single")

func _open_tree_control_menu():
	print("menu opened")
	$AirTree.hide()
	$WaterTree.hide()
	$EarthTree.hide()
	$FireTree.hide()
	$MagmaTree.hide()
	$SnoopTree.hide()
	$ClearPlots.hide()
	$ClearSinglePlot.show()
	$Return.show()
	$Water.show()
	


func _on_Return_pressed():
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$SnoopTree.show()
	$ClearPlots.show()
	$ClearSinglePlot.hide()
	$Return.hide()
	$Water.hide()
	emit_signal("close_menu")


func _on_Water_pressed():
	emit_signal("water_tree")



