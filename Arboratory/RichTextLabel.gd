extends RichTextLabel

var dialogue = [
	"This is Arboratory",
	"We're making a lot of cool trees",
	"More filler text",
	"End"
]

var dialogue_index = 0
signal showSprite
signal hideSprite


signal showSprite2
signal hideSprite2
var interactable = false

var choices = 0
var base = []
var numOptions = []
var optionIndex = 0
var numPressed = 0
var good = true


func select_dialogue():
	match Leveling.level:
		1:
			print('successfully did the thing')
			dialogue = ["insert tutorial dialogue here",
			"testing that it does the other thing"]
			emit_signal("showSprite")
		3:
			set_process_input(true)
			dialogue = ["insert item dialogue here"]
			emit_signal("showSprite")
			show()
		5:
			set_process_input(true)
			dialogue = ["Oh, hello!", "I didn't see you there.",
			"Do you need my help with something?"]
			base = ["My name is Yoon, but lately people have been calling me Mother Hen Yoon.",
			"You're welcome to call me whatever you like, really"]
			numOptions = [2, 0, 2, 1]
			emit_signal("showSprite")
			show()
			choices = 4
			
		_:
			hide()
			emit_signal("hideSprite")
			emit_signal("hideSprite2")
			set_process_input(false)

signal releaseTheButtons(duration, numButtons, good)
signal hideButtons()
var final = false

func _ready():
	select_dialogue()
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	
var waiting = false
	
func _input(event):
	#print('waiting: ' + str(waiting))
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton) && !waiting:
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
				#emit_signal("hideButtons")
			elif choices > 0:
				print("numOptions[optionIndex]: " + str(numOptions[optionIndex]))
				emit_signal("releaseTheButtons", 1, numOptions[optionIndex], good)
				print("choices: " + str(choices))
				choices -= 1
				if optionIndex < numOptions.size() and numOptions[optionIndex] != 0:
					waiting = true
				optionIndex += 1
			else:
				print("ok but")
				emit_signal("hideSprite")
				emit_signal("hideSprite2")
				hide()
				get_tree().get_root().find_node("Planting",true,false)._return_to_planting()
				set_process_input(false)
				#set_process_input(false)
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)


func _on_Button_pressed():
	good = true
	waiting = false
	numPressed += 1
	print("numPressed: " + str(numPressed))
	emit_signal("hideButtons")

	match (numPressed):
		1:
			set_bbcode("Aww well aren't you sweet?")
			set_visible_characters(0)
			dialogue = base
			dialogue_index = 0
			set_process_input(true)
		2:
			dialogue = ["O-oh goodness!", "Are you flirting with me?", "I-I...",
			"I don't know how to respond"]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
		3:
			dialogue = ["Hehe, well aren't you a charmer?", 
			"Well... I suppose it's alright.", "Just make sure to water the trees before we leave!"]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
			


func _on_Button2_pressed():
	good = false
	waiting = false
	numPressed += 1
	print("numPressed: " + str(numPressed))
	emit_signal("hideButtons")

	match (numPressed):
		1:
			set_bbcode("Oh! I guess I haven't introduced myself yet.")
			set_visible_characters(0)
			dialogue = base
			dialogue_index = -1
			set_process_input(true)
		2:
			dialogue = ["I'd rather you not."]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
		3:
			dialogue = ["*inhales*", "YOU CANT.", "KEEP.", "DOING THIS.",
			"*sighs*", "You know what? I've gotta run.", "Important hen business.",
			"Goodbye, my child."]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
