extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Farm.position.x = 80
	$Farm.position.y = 40
	$Farm.scale.x = .75
	$Farm.scale.y = .75


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _input(event):
	#if Input.is_action_pressed("ui_click"):
		#$SignalLabel.show_message(str(event.position))
