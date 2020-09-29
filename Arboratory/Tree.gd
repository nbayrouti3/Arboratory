extends Node

"""
Temporary variables for water
"""
# 86400 seconds = 1 day, so the plants can go 1 day before needing water
const TIME_UNTIL_DRY = 0
var last_watering_time = OS.get_unix_time()
var health = 100;
# variable to check how much time has passed since opening game
var prev_recorded_time = OS.get_unix_time()
signal deduct_health



# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	More temporary water functionality
	"""
	connect("deduct_health", self, "_on_deduct_health")

"""
Temporary water functionality
"""

func _process(delta):
	#check to see whether enough time has passed in real life for plants to need water
	if (OS.get_unix_time() - last_watering_time >= TIME_UNTIL_DRY) :
		#print("I need water!")
		#decrease 1 point of health every 10 min\
		#emit signal to start decrease of health
		emit_signal("deduct_health")
		
"""
Starts the health deduction timer if it's not already started
"""
func _on_deduct_health():
	if $healthDeduction.time_left == 0:
		$healthDeduction.start()

func _on_waterButton_pressed():
	print("I was watered!")
	last_watering_time = OS.get_unix_time()

func _on_healthDeduction_timeout():
	health -= 1
	print(health)
