extends StaticBody2D

var key_taken = false
var player_in_area = false
signal key1_collected

var collection_sound: AudioStreamPlayer2D

func _ready():
	collection_sound = get_node("/root/Game/AudioStreamPlayer2D2")

	# If the key was already collected (based on Global), remove it from the scene
	if Global.key1_collected:
		queue_free()  # Remove the key if it was collected previously

func _on_Area2D_body_entered(body):
	if body.has_method('player'):
		player_in_area = true
		print('Player in area')

func _process(delta):
	if player_in_area and not key_taken:
		if Input.is_action_just_pressed('chat'):
			_collect_key()

func _collect_key():
	if not key_taken:
		key_taken = true  # Mark the key as taken
		print('Key 1 collected')

		# Update the global state to reflect that the key has been collected
		Global.key1_collected = true
		
		# Emit the signal
		emit_signal("key1_collected")

		# Play the collection sound (only once)
		collection_sound.play()

		# Remove the key from the scene after it has been collected
		queue_free()

func _on_Area2D_body_exited(body):
	if body.has_method('player'):
		player_in_area = false


