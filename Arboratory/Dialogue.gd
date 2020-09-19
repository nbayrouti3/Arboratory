#Dialogue.gd
extends RichTextLabel

var dialogue = [
	"Arboratory Arboratory Arboratory Arboratory Arboratory",
	"trees trees trees trees trees trees trees"
]

var dialogue_index = 0


func _ready():
	set_visible_characters(0)
	set_bbcode(dialogue[dialogue_index])
	set_process_input(true)
	
	
func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH && event.is_processed():
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
