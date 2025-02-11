extends Node2D

onready var solution1 = get_node("Solution1")
onready var solution2 = get_node("Solution2")
onready var solution3 = get_node("Solution3")
onready var solution4 = get_node("Solution4")
var tolerance = 5.0  
var label = Label
var time = Timer
var collection_sound: AudioStreamPlayer2D
var background_music: AudioStreamPlayer2D

var target_positions = {
	'Solution1': Vector2(296, 176),
	'Solution2': Vector2(296, 320),
	'Solution3': Vector2(295, 39),
	'Solution4': Vector2(297, 456)
}

func _ready():
	collection_sound = get_node("/root/Node2D/AudioStreamPlayer2D2")
	background_music = get_node("/root/Node2D/AudioStreamPlayer2D3")
	background_music.play()
	label = $Label
	time = $Timer
	
	time.start()
	time.connect("timeout", self, "on_time_timeout")
	
func _process(delta):
	update_label_text()
	
	if solution1.position in target_positions.values() and solution2.position in target_positions.values() and solution3.position in target_positions.values() and solution4.position in target_positions.values():
		check_if_correct()


func check_if_correct():
	if solution1.position == target_positions['Solution1'] and solution2.position == target_positions['Solution2'] and solution3.position == target_positions['Solution3'] and solution4.position == target_positions['Solution4']:
		Global.won_minigame1 = true
		game_over()
	else:
		game_over()
		
func update_label_text():
	label.text = str(ceil(time.time_left))

func on_time_timeout():
	game_over()
	
func game_over():
	collection_sound.play()  # Play the collection sound
	background_music.stop()  # Stop the background music
	get_tree().change_scene("res://scenes/Game.tscn")
