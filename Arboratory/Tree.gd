extends Area2D

"""
Variables relating to water functionality.
"""
# 86400 seconds = 1 day, so the plants can go 1 day before needing water
const TIME_UNTIL_DRY = 10
var last_watering_time = OS.get_unix_time()
var health = 100
var healthDeduction = 1
var tree_type

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	"""
	Checks to see whether enough time has passed in real life for plants to 
	need water. If enough time has passed, deduct health.
	The water tree doesn't need water, so it doesn't check for this condition.
	"""
	if (tree_type != "water_tree" and 
			OS.get_unix_time() - last_watering_time >= TIME_UNTIL_DRY) :
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
	print(tree_type, " was watered!")
	last_watering_time = OS.get_unix_time()
	health = 100;
	$healthDeduction.stop()

"""
A timer to deduct health every 5 seconds.
"""
func _on_healthDeduction_timeout():
	health -= 1
	print(tree_type, " needs water!")
	print("health: ", health)

#choose tree you want to plant
func _choose_tree(type):
	$AnimatedSprite.animation = type
	tree_type = $AnimatedSprite.animation

#removes selected tree	
func _remove_tree():
	queue_free()
	
