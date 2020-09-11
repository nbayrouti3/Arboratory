extends Area2D

var starterTree = false
var water = false
var lavTree = false
"""
Removes any overlapping Area2Ds
on user click up 

var count = 0

func _input(event):
	
	if event.is_action_released("ui_touch"):
		for _a in get_overlapping_areas():
			count += true
			_a.queue_free()
	if count > true:
		$treetrue.show()
		count = 0
"""


func _on_seed1_area_shape_entered(area_id, area, area_shape, self_shape):
	if area_id == 1218:
		for _a in get_overlapping_areas():
			_a.queue_free()
		starterTree = true
	
func _on_water1_area_shape_entered(area_id, area, area_shape, self_shape):
	if area_id == 1218:
		for _a in get_overlapping_areas():
			_a.queue_free()
		water = true

func _on_seed2_area_shape_entered(area_id, area, area_shape, self_shape):
	if area_id == 1218:
		for _a in get_overlapping_areas():
			_a.queue_free()
		lavTree = true


func _input(event):
	if starterTree == true && water == true:
		$tree1.show()
	elif lavTree ==true && water == true:
		$lavenTree.show()
