extends KinematicBody2D

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT  
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_area = false

var collection_sound: AudioStreamPlayer2D

onready var progress_bar: ProgressBar = $"../CanvasLayer/ProgressBar"

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	collection_sound = get_node("/root/Game/AudioStreamPlayer2D3")

func _process(delta):
	if player_in_area:
		current_state = IDLE
		if Input.is_action_just_pressed('chat'):
			print('chatting')
			run_dialogue()
			$AnimatedSprite.play("idle")
	
	if current_state == IDLE or current_state == NEW_DIR:
		$AnimatedSprite.play('idle')
	elif current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite.play('walk_w')
		if dir.x == 1:
			$AnimatedSprite.play('walk_e')
		if dir.y == -1:
			$AnimatedSprite.play('walk_n')
		if dir.y == 1:
			$AnimatedSprite.play('walk_s')
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = _choose([Vector2.RIGHT, Vector2.UP, Vector2.DOWN, Vector2.LEFT])  # Random direction
				current_state = MOVE  # After choosing a direction, start moving
			MOVE:
				_move(delta)

func run_dialogue():
	is_chatting = true
	is_roaming = false
	var new_dialog = Dialogic.start('FDP')
	add_child(new_dialog)
	new_dialog.connect("timeline_end", self, 'after_dialogue')
	
func after_dialogue(arg):
	print(arg)
	print('running after dialogue')
	is_chatting = false 
	is_roaming = true
	current_state = MOVE
	$Timer.start()
	
	if not Global.npc1_talked_to:
		print('updating progress bar')
		collection_sound.play()
		Global.progress_value += 1
		progress_bar.value += 1
		Global.npc1_talked_to = true
	
func _choose(array):
	array.shuffle()
	return array.front()

# Updated _move function
func _move(delta):
	if !is_chatting:
		# Create a velocity vector based on direction and speed
		var velocity = dir * speed
		
		# Move using move_and_slide, which handles collisions automatically
		move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.has_method('player'):
		player_in_area = true
		print('player is in area')

func _on_Area2D_body_exited(body):
	if body.has_method('player'):
		player_in_area = false


func _on_Timer_timeout():
	$Timer.wait_time = _choose([0.5, 2, 5])
	current_state = _choose([IDLE, NEW_DIR, MOVE])  # You should randomly change states here




