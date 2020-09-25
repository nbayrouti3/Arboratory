extends Node2D

#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
	$Seeds.get_node("aSeeds2").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/seed-laventree.png")
	pass 

