extends Node

export (PackedScene) var Tree

var anim
var free_tree
var trees = []
var trees_size = Vector2(7,7)
var ready_to_clear_plot
var watering_time


# Called when the node enters the scene tree for the first time.
func _ready():
	$Farm.position.x = 0
	$Farm.position.y = 0
	$Farm.scale.x = 2
	$Farm.scale.y = 2
	
	for x in range(trees_size.x):
		trees.append([])
		for y in range(trees_size.y):
			trees[x].append(null)
	ready_to_clear_plot = false
	watering_time = false
	
func _process(delta):
	"""
	Loop through tree array and have every tree execute their special power.
	For now, just the rain tree (can water other trees).
	"""
	for x in trees_size.x:
		for y in trees_size.y:
			#For each tree, call special power
			if trees[x][y] != null:
				trees[x][y]._special_power()
	pass

#handles removing and planting of trees
func _plant_tree(pos_x,pos_y,plot_x,plot_y):
	if free_tree == true:
		if trees[plot_x][plot_y]!= null:
			ready_to_clear_plot = true
			_new_plot()
			trees[plot_x][plot_y]._remove_tree()
			trees[plot_x][plot_y] = null
			free_tree = false
			$Farm.clearing_time = false
			ready_to_clear_plot = false
	
	elif watering_time:
		if trees[plot_x][plot_y]!= null:
			trees[plot_x][plot_y]._water_tree()
			watering_time = false
			$Farm.watering_time = false
			print("water_tree")
		else:
			watering_time = false
			$Farm.watering_time = false
	
	elif trees[plot_x][plot_y] != null:
		if $Farm.open_menu == true:
			for x in range(trees_size.x):
				for y in range(trees_size.y):
					if trees[x][y] != null:
						trees[x][y]._hide_stats()
						print("tree here")
			trees[plot_x][plot_y]._show_stats()
		else:
			trees[plot_x][plot_y]._hide_stats()
	else:
		var tree = Tree.instance()
		add_child(tree)
		trees[plot_x][plot_y] = tree
		tree.tree_x_index = plot_x
		tree.tree_y_index = plot_y
		tree.position.x = pos_x
		tree.position.y = pos_y
		tree._choose_tree(anim)
		tree.connect("_water_tree_from_tree", self, "_water_tree_from_tree")
	

		
		
#handles choosing the tree you want to plant
func _select_tree(type):
	if type == "water_tree":
		anim = "water_tree"
	if type == "fire_tree":
		anim = "fire_tree"
	if type == "earth_tree":
		anim = "earth_tree"
	if type == "air_tree":
		anim = "air_tree"
	if type == "magma_tree":
		anim = "magma_tree"
	if type == "snoop_tree":
		anim = "snoop_tree"
	$Farm._ready_to_plant()
	$Farm.clearing_time = false
	free_tree = false
	

#clears all plots		
func _new_farm():
	$Farm._clear_plots()
	
#clears a single plot
func _new_plot():
	if ready_to_clear_plot == true:
		$Farm._clear_single_plot()
	else:
		free_tree = true
		$Farm.clearing_time = true
		
func _water_tree():
	$Farm.watering_time = true
	watering_time = true
	print("watering time")
	
"""
When a tree emits this signal, waters the tree in the specific plot.
"""	
func _water_tree_from_tree(plot_x, plot_y):
	if (plot_x < trees_size.x and plot_y < trees_size.y \
		and trees[plot_x][plot_y] != null):
			trees[plot_x][plot_y]._water_tree()
			watering_time = false
			$Farm.watering_time = false
	
	





