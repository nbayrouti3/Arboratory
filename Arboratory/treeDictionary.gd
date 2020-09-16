extends Node

onready var Everything : = get_node("../Everything") as Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Everything)
	print("I am here")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var tree_dir = {
	"seed1": [
		{
		"id" : "00",
		"name" : "Sample Tree",
		"desc" : "A tree made for testing",
		"seedID" : "res://Assets/Seeds/SampleSeed.png",
		"sapID" : "res://",
		"treeID" : "res://Assets/Trees/SamplePlant.png"
		}
	],

	"seed2" : [
		{
			"id" : "02",
			"name" : "Lavender Tree",
			"desc" : "The good smelling tree",
			"seedID" : "res://Assets/Seeds/seed-laventree.png",
			"sapID" : "res://",
			"treeID" : "res://"
		}
	]
}
