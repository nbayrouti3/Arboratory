extends Node

var seed_data

func _ready():
	var seedData_file = File.new()
	seedData_file.open("res://Data/Encyclotreedia.json", File.READ)
	var seedData_json = JSON.parse(seedData_file.get_as_text())
	seedData_file.close()
	seed_data = seedData_json.result
	print(seed_data)
	for key in seed_data:
		seed_data[str(key)]["seedImage"] = load(seed_data[str(key)]["seedImage"])
	print(seed_data)
