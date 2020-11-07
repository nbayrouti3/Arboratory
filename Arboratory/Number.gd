extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	self.text = str(Leveling.get_level())
