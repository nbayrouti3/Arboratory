extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var level = 1

var experience = 0
var required_experience = get_next_level_xp(level + 1)

#increases the total amount of xp you have
#levels up if the experience total meets the amount of experience needed
func gain_xp(value):
	experience += value
	if (experience >= required_experience):
		gain_level()
		experience = 0;

#increases level by 1
func gain_level():
	level += 1
	required_experience = get_next_level_xp(level + 1)

#returns the xp needed to get to the next level
func get_next_level_xp(level_num):
	return round(pow(level_num, 1.2)) #required experience is increased exponentially, can be fine tuned later

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
