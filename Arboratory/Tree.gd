extends Area2D

"""
Variables relating to water functionality.
"""
const TIME_UNTIL_DRY = 10
var last_watering_time = OS.get_unix_time()
var health = 100
var healthDeduction = 1
var treeName
var wetness = "Wet"
var time_passed_since_watering = OS.get_unix_time() - last_watering_time

var tree_x_index
var tree_y_index
signal _water_tree_from_tree

"""
Variables relating to growth
"""
#15 min of in-game time must pass before tree is grown
const TIME_UNTIL_GROWN = 10
var time_planted
var tree_maturity = "Sapling"


# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/Lato-Regular.ttf")
	dynamic_font.size = 20
	$TreeStats/TreeStatPanel.set_position(Vector2(1150,50))
	$TreeStats/TreeStatPanel.set_size(Vector2(300,400))
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeHealth.set_position(Vector2(1160,70))
	$TreeStats/TreeHealth.add_font_override("font",dynamic_font)
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeName.set_position(Vector2(1250,51))
	$TreeStats/TreeName.add_font_override("font",dynamic_font)
	$TreeStats/TreeName.hide()
	$TreeStats/TreeWaterStatus.set_position(Vector2(1160,90))
	$TreeStats/TreeWaterStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.set_position(Vector2(1160,110))
	$TreeStats/TreeSpecialProperties.add_font_override("font",dynamic_font)
	$TreeStats/TreeSpecialProperties.hide()
	$TreeStats/TreeMaturityStatus.set_position(Vector2(1160,130))
	$TreeStats/TreeMaturityStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeMaturityStatus.hide()
	#sets the time that the tree was planted to be the current time
	time_planted = OS.get_unix_time()


func _process(delta):
	check_water_status()
	check_growth_status()
	
		
"""
Checks to see whether enough time has passed in real life for plants to 
need water. If enough time has passed, deduct health.
"""
func check_water_status():
	if treeName == "water_tree" or treeName == "water_sapling":
		time_passed_since_watering = 0
		
	else:
		time_passed_since_watering = OS.get_unix_time() - last_watering_time
	
	if 13 - (time_passed_since_watering) > 10:
		wetness = "Wet"
		_update_stats()
	elif 13 - (time_passed_since_watering) <=10 and 13-(time_passed_since_watering)>= 0:
		wetness = "Will Dry In " + str(13 - (time_passed_since_watering))
		_update_stats()
	else:
		wetness = "Dry"
	if (time_passed_since_watering >= TIME_UNTIL_DRY) :
		deduct_health(healthDeduction)

"""
Checks to see if enough time has passed for the tree to grow.
If enough time has passed, changes the texture of the tree.
"""
func check_growth_status():
	if (OS.get_unix_time() - time_planted >= TIME_UNTIL_GROWN):
		tree_maturity = "Mature"
		match ($AnimatedSprite.animation):
			"air_sapling":
				_choose_tree("air_tree")
			"water_sapling":
				_choose_tree("water_tree")
			"earth_sapling":
				_choose_tree("earth_tree")
			"fire_sapling":
				_choose_tree("fire_tree")
			"magma_sapling":
				_choose_tree("magma_tree")
			"snoop_sapling":
				_choose_tree("snoop_tree")

"""
Starts the health deduction timer if it's not already started
"""
func deduct_health(healthDeduction):
	if $healthDeduction.time_left == 0:
		$healthDeduction.start()

"""
When the water button is pressed, resets countdown clock for water and stops
the health deduction timer.
"""
func _water_tree():
	last_watering_time = OS.get_unix_time()
	health = 100;
	wetness = "Wet"
	_update_stats()
	$healthDeduction.stop()

"""
A timer to deduct health every 5 seconds.
"""
func _on_healthDeduction_timeout():
	health -= 1
	_update_stats()
	
func _show_stats():
	$TreeStats/TreeStatPanel.show()
	$TreeStats/TreeHealth.show()
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeName.show()
	$TreeStats/TreeName.set_text(treeName)
	$TreeStats/TreeWaterStatus.show()
	#$TreeStats/TreeWaterStatus.set_text("Water Status: Wet")
	$TreeStats/TreeSpecialProperties.show()
	$TreeStats/TreeSpecialProperties.set_text("Special Properties: Not ready")
	$TreeStats/TreeMaturityStatus.show()
	#$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)
	
	
func _hide_stats():
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeName.hide()
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.hide()
	$TreeStats/TreeMaturityStatus.hide()

func _update_stats():
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeWaterStatus.set_text("Water Status: " + wetness)
	$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)

#choose tree you want to plant
func _choose_tree(type):
	$AnimatedSprite.animation = type
	treeName = type

#removes selected tree	
func _remove_tree():
	queue_free()
	
func _special_power():
	if treeName == "water_tree" or treeName == "water_sapling":
		"""
		Water all the trees in the surrounding 3x3 grid.
		"""
		for x in range(tree_x_index-1, tree_x_index + 2):
			for y in range(tree_x_index-1, tree_y_index + 2):
				emit_signal("_water_tree_from_tree", x, y)
