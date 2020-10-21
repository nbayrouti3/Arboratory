extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tree_appearance 
onready var tree_number 
onready var item_name
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.set_scale(Vector2(.25,.25))
	print("treenumber: "+ str(tree_number))
	if tree_number == 0:
		$TextureRect.texture = load("res://Assets/Plants/saplings/air_sapling.png")
		tree_appearance = "air_sapling"
	elif tree_number == 1:
		$TextureRect.texture = load("res://Assets/Plants/saplings/fire_sapling.png")
		tree_appearance = "fire_sapling"
	elif tree_number == 2:
		$TextureRect.texture = load("res://Assets/Plants/saplings/earth_sapling.png")
		tree_appearance = "earth_sapling"
	elif tree_number == 3:
		$TextureRect.texture = load("res://Assets/Plants/saplings/magma_sapling.png")
		tree_appearance = "magma_sapling"
	elif tree_number == 4:
		$TextureRect.texture = load("res://Assets/Plants/saplings/snoop_dogg_sapling.png")
		tree_appearance = "snoop_sapling"
	elif tree_number == 5:
		$TextureRect.texture = load("res://Assets/Plants/saplings/water_sapling.png")
		tree_appearance = "water_sapling"
	elif item_name == "water_tree":
		$TextureRect.texture = load("res://Assets/Plants/seeds/water_seed.png")
	elif item_name == "air":
		$TextureRect.texture = load("res://Assets/Plants/seeds/air_seed.png")
	elif item_name == "earth":
		$TextureRect.texture = load("res://Assets/Plants/seeds/earth_seed.png")
	elif item_name == "fire":
		$TextureRect.texture = load("res://Assets/Plants/seeds/fire_seed.png")
	elif item_name == "magma":
		$TextureRect.texture = load("res://Assets/Plants/seeds/magma_seed.png")
	elif item_name == "snoop":
		$TextureRect.texture = load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
	

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
