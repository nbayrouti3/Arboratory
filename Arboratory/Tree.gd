extends Area2D

"""
Variables relating to water functionality.
"""
# 86400 seconds = 1 day, so the plants can go 1 day before needing water
const TIME_UNTIL_DRY = 10
var last_watering_time = OS.get_unix_time()
var health = 100
var healthDeduction = 1
var treeName
var wetness = "Wet"
var time_passed_since_watering = OS.get_unix_time() - last_watering_time

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


func _process(delta):
	"""
	Checks to see whether enough time has passed in real life for plants to 
	need water. If enough time has passed, deduct health.
	The water tree doesn't need water, so it doesn't check for this condition.
	"""
	if treeName == "water_tree": 
		time_passed_since_watering = 0
	else:
		time_passed_since_watering = OS.get_unix_time()-last_watering_time
		
	if 13 - (time_passed_since_watering) > 10:
		wetness = "Wet"
		_update_stats()
	elif 13 - (time_passed_since_watering) <= 10 \
		and 13 - (time_passed_since_watering) >= 0:
		wetness = "Will Dry In " + str(13 - (time_passed_since_watering))
		_update_stats()
	else:
		wetness = "Dry"
	if (time_passed_since_watering >= TIME_UNTIL_DRY) :
		deduct_health(healthDeduction)

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
	
	
func _hide_stats():
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeName.hide()
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.hide()

func _update_stats():
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeWaterStatus.set_text("Water Status: " + wetness)
#choose tree you want to plant
func _choose_tree(type):
	$AnimatedSprite.animation = type
	treeName = type

#removes selected tree	
func _remove_tree():
	queue_free()
	
