extends Node2D

#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
	$Seeds.get_node("aSeeds2").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/seed-laventree.png")
	$Seeds.get_node("aSeeds3").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
	$Seeds.get_node("aSeeds4").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/Lighting_seed.png")
	pass 



func _on_treeDex_button_pressed():
	$treeDex.show()
	get_tree().paused = true
