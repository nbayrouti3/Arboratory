<<<<<<< HEAD
extends Area2D
=======
extends Node
"""
Variables relating to water functionality.
"""
# 86400 seconds = 1 day, so the plants can go 1 day before needing water
const TIME_UNTIL_DRY = 10
var last_watering_time = OS.get_unix_time()
var health = 100
var healthDeduction = 1
>>>>>>> 7e0b6f3fe790eaa6338a355cf405ce23c93ccc36


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

<<<<<<< HEAD
#choose tree you want to plant
func _choose_tree(type):
	$AnimatedSprite.animation = type

#removes selected tree	
func _remove_tree():
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
=======
func _process(delta):
	"""
	Checks to see whether enough time has passed in real life for plants to 
	need water. If enough time has passed, deduct health.
	"""
	if (OS.get_unix_time() - last_watering_time >= TIME_UNTIL_DRY) :
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
func _on_waterButton_pressed():
	print("I was watered!")
	last_watering_time = OS.get_unix_time()
	$healthDeduction.stop()

"""
A timer to deduct health every 5 seconds.
"""
func _on_healthDeduction_timeout():
	health -= 1
	print("I need water!")
	print("health: ", health)
>>>>>>> 7e0b6f3fe790eaa6338a355cf405ce23c93ccc36
