extends Area2D

"""
Removes any overlapping Area2Ds
on user click up 
"""
var count = 0

func _input(event):
	
	if event.is_action_released("ui_touch"):
		for _a in get_overlapping_areas():
			count += 1
			_a.queue_free()
	if count > 1:
		$tree1.show()
		count = 0
