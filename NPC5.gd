extends "res://scenes/NPC1.gd"


func run_dialogue():
	is_chatting = true
	is_roaming = false
	var new_dialog = Dialogic.start('CDU')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, 'after_dialogue')

func after_dialogue(arg):
	print(arg)
	print('running after dialogue')
	is_chatting = false 
	is_roaming = true
	current_state = MOVE
	$Timer.start()
	
	if not Global.npc5_talked_to:
		print('updating progress bar')
		collection_sound.play()
		Global.progress_value += 1
		progress_bar.value += 1
		Global.npc5_talked_to = true
