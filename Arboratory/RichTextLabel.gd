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

signal showSprite3
signal hideSprite3

var interactable = false

var choices = 0
#var base = []
var numOptions = []
var optionIndex = 0
var numPressed = 0
var good = true
var numChars = 0
#var charDialogue = []
var order = []
var orderIndex = 0
#var knowledgeIndex = 0
#var loveIndex = 0

var info = {}

func select_dialogue():
	match Leveling.level:
		1:
			print('successfully did the thing')
			dialogue = ["Hello there!",
			"I am here to help you on your journey to discover every tree in the arboretum.",
			"You are in the Merge Area. Click or tap the TreeDex button to check how many trees you have discovered.Trees will be grayed out until they are discovered.",
			"Drag a seed to the middle merge area and water it to create a sapling!",
			"Click or tap the Farm button to go to the farm and grow your saplings.",
			"In the farm, click or tap an inventory slot and then click or tap a plot to plant. Click or tap a tree to see its stats and Return to hide them!",
			"Warning! Trees will dry out and lose health if not watered. Press the water button and then a tree to water it.",
			"You may find that some trees have special properties, so watch out for those!",
			"Click or tap Clear Single Plot and then a plot to harvest one tree, or harvest all plots with Clear Plots.",
			"Harvesting a sapling or dead tree will give 1 seed, while harvesting a mature tree will give 2 seeds. Click or tap Merge to go back to the Merge Area.",
			"If you have 2 seeds of the same type and 2 seeds of another type, you can attempt merging to discover a new tree by dragging 2 seeds together in the middle!"]
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0, 
			"numOptions": [], "dialogue": [[]]
			}}
			emit_signal("showSprite")
			emit_signal("hideSprite2") 
			emit_signal("hideSprite3")
		3:
			set_process_input(true)
			show()
			dialogue = ["In order to help you on your journey, I'll give you some items to use that may help you discover more trees!",
			"Drag the item to the middle with a seed to attempt a new discovery."]
			
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0, 
			"numOptions": [], "dialogue": [[]]
			}}
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")

		5:
			show()
			set_process_input(true)
			dialogue = ["Uh oh", "Looks like there's a new tree on the block",
			"I wonder what she wants now..."]
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0,
				"numOptions": [],
				"dialogue": [["You know that's not my name, why are you here?"], 
				["And how, pray tell, are you going to do that?"],
				["Goodness"]]},
				1: {"char": "love", "dialogue index": 0, "choices": 0, "numOptions": [],
				"dialogue": [["Hello darling", "I'm the Love Tree.", 
				"Owly, baby, it's been a while"], 
				["I noticed the lovely work the professor is doing and thought I would lend a hand"],
				["By showing the professor how to love trees, of course!", 
				"What?", "I thought you were all about gaining new knowledge"],
				["Some trees might talk to you now", 
				"All you have to do is pick a response from the options that pop up on the screen", 
				"Try it now with my little bird friend here"]]},
				2: {"char": "yoon", "dialogue index": 0, "choices": 4, "numOptions": [2, 0, 2, 1],
				"dialogue": [["Oh, hello!", "I didn't see you there.", 
				"Do you need my help with something?"], 
				["My name is Yoon, but lately people have been calling me Mother Hen Yoon.",
				"You're welcome to call me whatever you like, really"]]}}

			numChars = 3
			order = [0, 1, 0, 1, 0, 1, 0, 1, 2]

			#"Do you need my help with something?"]
			#base = ["My name is Yoon, but lately people have been calling me Mother Hen Yoon.",
			#"You're welcome to call me whatever you like, really"]
			#numOptions = [2, 0, 2, 1]
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")
			
			#choices = 4

			
		_:
			hide()
			emit_signal("hideSprite")
			emit_signal("hideSprite2")
			set_process_input(false)

signal releaseTheButtons(duration, numButtons, good)
signal hideButtons()
signal hideBox()
signal showBox()
var final = false

func _ready():
	select_dialogue()
	emit_signal("showBox")
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	
var waiting = false
	
func _input(event):
	#print('waiting: ' + str(waiting))
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton) && !waiting:
		var character = 0
		if order.size() > 0:
			character = order[orderIndex]
		numOptions = info[character]["numOptions"]
		choices = info[character]["choices"]
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
				#emit_signal("hideButtons")
			elif numChars > 0:
				#knowledge tree is 0, love tree 1, yoon 2
				if character == 2:
					numChars = 0
				else:
					orderIndex += 1
					character = order[orderIndex]
					set_sprite(character)
					load_dialogue(character)
					
				
			elif optionIndex < numOptions.size() and choices > 0:
				emit_signal("releaseTheButtons", 1, numOptions[optionIndex], good)
				print("choices: " + str(choices))
				choices -= 1
				if numOptions[optionIndex] != 0:
					waiting = true
				optionIndex += 1
			else:
				print("ok but")
				emit_signal("hideSprite")
				emit_signal("hideSprite2")
				emit_signal("hideSprite3")
				emit_signal("hideBox")
				hide()
				get_tree().get_root().find_node("BaseFarmGrid",true,false)._exit_farm()
				set_process_input(false)
				#set_process_input(false)
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)

func load_dialogue(character):
	var index = info[character]["dialogue index"]
	dialogue = info[character]["dialogue"][index]
	info[character]["dialogue index"] += 1
	dialogue_index = -1
	set_process_input(true)

func set_sprite(character):
	print("info[character]: " + str(info[character]))
	match info[character]["char"]:
		"knowledge":
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")
		"love":
			emit_signal("showSprite2")
			emit_signal("hideSprite")
			emit_signal("hideSprite3")
		"yoon":
			emit_signal("showSprite3")
			emit_signal("hideSprite")
			emit_signal("hideSprite2")

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
			dialogue = info[2]["dialogue"][1]
			dialogue_index = -1
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
			dialogue = info[2]["dialogue"][1]
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
