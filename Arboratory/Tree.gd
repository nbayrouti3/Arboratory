extends Area2D

"""
Variables relating to water functionality.
"""
const TIME_UNTIL_DRY = 10
const MAX_HEALTH = 100
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
const TIME_UNTIL_GROWN = 20
var time_planted
var tree_maturity = "Sapling"

"""
Variables relating to death
"""
var dead = false

"""
Variables relating to sunlight
"""
var sunlight


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
	$TreeStats/TreeDeathStatus.set_position(Vector2(1160,150))
	$TreeStats/TreeDeathStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeDeathStatus.hide()
	$TreeStats/TreeSunlight.set_position(Vector2(1160,170))
	$TreeStats/TreeSunlight.add_font_override("font",dynamic_font)
	$TreeStats/TreeSunlight.hide()
	#sets the time that the tree was planted to be the current time
	time_planted = OS.get_unix_time()


func _process(delta):
	if (not dead):
		check_water_status()
		check_growth_status()
	check_death_status()
	_update_stats()
	
		
"""
Checks to see whether enough time has passed in real life for plants to 
need water. If enough time has passed, deduct health.
"""
func check_water_status():
	if treeName == "water":
		time_passed_since_watering = 0
		
	else:
		time_passed_since_watering = OS.get_unix_time() - last_watering_time
	
	if 13 - (time_passed_since_watering) > 10:
		wetness = "Wet"
		#_update_stats()
	elif 13 - (time_passed_since_watering) <=10 and 13-(time_passed_since_watering)>= 0:
		wetness = "Will Dry In " + str(13 - (time_passed_since_watering))
		#_update_stats()
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
		$AnimatedSprite.set_frame(1)
		
"""
Checks if the tree health is 0. If it is, change the appearance to a dead tree.
Also, set the tree death variable to true.
"""
func check_death_status():
	if (health == 0):
		$AnimatedSprite.animation = "dead"
		if (tree_maturity == "Mature"):
			$AnimatedSprite.set_frame(1)
		else:
			$AnimatedSprite.set_frame(0)
		dead = true
		$healthDeduction.stop()

func is_dead():
	return dead

"""
Starts the health deduction timer if it's not already started
"""
func deduct_health(healthDeduction):
	if $healthDeduction.time_left == 0 and not dead:
		$healthDeduction.start()

"""
When the water button is pressed, resets countdown clock for water and stops
the health deduction timer.
"""
func _water_tree():
	if not dead:
		last_watering_time = OS.get_unix_time()
		health = MAX_HEALTH;
		wetness = "Wet"
		#_update_stats()
		$healthDeduction.stop()

"""
A timer to deduct health every 5 seconds.
"""
func _on_healthDeduction_timeout():
	health -= 1
	#_update_stats()
	
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
	$TreeStats/TreeDeathStatus.show()
	$TreeStats/TreeSunlight.show()
	#$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)
	
	
func _hide_stats():
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeName.hide()
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.hide()
	$TreeStats/TreeMaturityStatus.hide()
	$TreeStats/TreeDeathStatus.hide()
	$TreeStats/TreeSunlight.hide()

func _update_stats():
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeWaterStatus.set_text("Water Status: " + wetness)
	$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)
	$TreeStats/TreeDeathStatus.set_text("Dead: " + str(dead))
	$TreeStats/TreeSunlight.set_text("Sunlight: " + str(sunlight))

#choose tree you want to plant
func _choose_tree(type):
	match (type):
		"air_sapling":
			treeName = "air"
		"water_sapling":
			treeName = "water"
		"earth_sapling":
			treeName = "earth"
		"fire_sapling":
			treeName = "fire"
		"magma_sapling":
			treeName = "magma"
		"snoop_sapling":
			treeName = "snoop"
		"cotton_candy_sapling":
			treeName = "cottoncandy"
		"lightning_sapling":
			treeName = "lightning"
		"bunny_sapling":
			treeName = "bunny"
		"sand_sapling":
			treeName = "sand"
	$AnimatedSprite.animation = treeName
	$AnimatedSprite.set_frame(0)

#removes selected tree	
func _remove_tree():
	queue_free()
	
func _special_power():
	if treeName == "water":
		"""
		Water all the trees in the surrounding 3x3 grid.
		"""
		for x in range(tree_x_index-1, tree_x_index + 2):
			for y in range(tree_y_index-1, tree_y_index + 2):
				#print("x: " + str(x) + "y: " + str(y))
				emit_signal("_water_tree_from_tree", x, y)
