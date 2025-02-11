extends Node

var is_dragging = false

var player_position = Vector2.ZERO

var progress_value = 0

var key1_collected = false

var won_minigame1 = false

var npc1_talked_to = false

var npc2_talked_to = false

var npc3_talked_to = false

var npc4_talked_to = false

var npc5_talked_to = false

func _process(delta):
	if progress_value == 6:
		yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://scenes/EndScene.tscn")

