extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var level = 1

var experience = 0
var required_experience = get_next_level_xp(level)

#increases the total amount of xp you have
#levels up if the experience total meets the amount of experience needed
func gain_xp(value):
	print('xp gained!')
	var mult = value * level
	experience += mult
	if (experience >= required_experience):
		gain_level()
		experience = 0;

#increases level by 1
func gain_level():
	level += 1
	required_experience = get_next_level_xp(level)

#returns the xp needed to get to the next level
func get_next_level_xp(level_num):
	return 14 * level_num

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
