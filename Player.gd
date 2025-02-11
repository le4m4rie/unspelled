extends KinematicBody2D

# Declare speed and other variables
export var walk_speed = 200  # Speed at which the player walks
onready var _animated_sprite = $AnimatedSprite

# Velocity for movement
var velocity = Vector2.ZERO

onready var progress_bar: ProgressBar = $"../CanvasLayer/ProgressBar"

var collection_sound: AudioStreamPlayer2D

func _ready():
	collection_sound = get_node("/root/Game/AudioStreamPlayer2D2")
	if Global.won_minigame1 == true:
		Global.progress_value += 1
		collection_sound.play()
	
	# If we're returning to the original scene, set the player position and progress bar from Global
	if Global.player_position != Vector2.ZERO:
		position = Global.player_position  # Restore player position
	if Global.progress_value != 0:
		progress_bar.value = Global.progress_value  # Restore progress bar value

func _process(_delta):
	# Get input from the player to set the movement direction
	velocity = Vector2.ZERO  # Reset velocity each frame

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		_animated_sprite.play("runright")
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		_animated_sprite.play("runleft")
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		_animated_sprite.play("runup")
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		_animated_sprite.play("rundown")
	else:
		# Play idle animation if no key is pressed
		_animated_sprite.play("idle")

	# Normalize the velocity to prevent faster diagonal movement
	velocity = velocity.normalized() * walk_speed

	# Move the player with the current velocity
	move_and_slide(velocity)

	# Update the global player position and progress bar value
	Global.player_position = position  # Store the player's position
	Global.progress_value = progress_bar.value  # Store the progress bar value

	
func player():
	pass



