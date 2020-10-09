extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#choose tree you want to plant
func _choose_tree(type):
	$AnimatedSprite.animation = type

#removes selected tree	
func _remove_tree():
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
