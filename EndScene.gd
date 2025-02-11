extends Control

var collection_sound: AudioStreamPlayer2D

func _ready():
	collection_sound = $AudioStreamPlayer2D
	collection_sound.play()

