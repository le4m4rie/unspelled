extends StaticBody2D

onready var key = $"../RigidBody2D"  # Assuming this is the reference to the key item
var player_in_area = false
var has_key = false

# Called when the object is ready (initialization)
func _ready():
	# Check if the key is already collected globally (even before the player enters the area)
	if Global.key1_collected:
		has_key = true

	# Connect the signal for when the key is collected
	if key:
		key.connect("key1_collected", self, "on_key_collected")

# Called every frame to process input
func _process(delta):
	# If the player is in the area and presses 'chat' to interact with the object
	if player_in_area and Input.is_action_just_pressed('chat'):
		if has_key and not Global.won_minigame1:
			# Start the mini-game scene if the player has the key
			get_tree().change_scene("res://scenes/DragAndDropGame/DragAndDrop.tscn")
		elif not has_key and not Global.won_minigame1:
			# Show dialog if the player does not have the key
			var new_dialog = Dialogic.start('GoldenChest')
			add_child(new_dialog)
		else:
			var won_dialog = Dialogic.start('GoldenChestWon')
			add_child(won_dialog)
			

# Called when the key is collected (signal handler)
func on_key_collected():
	has_key = true  # Update the status to reflect that the player now has the key

# Detect if the player enters the area
func _on_Area2D_body_entered(body):
	if body.has_method('player'):
		player_in_area = true

# Detect if the player exits the area
func _on_Area2D_body_exited(body):
	if body.has_method('player'):
		player_in_area = false
