extends Control

var collection_sound: AudioStreamPlayer2D
var click_sound: AudioStreamPlayer2D

func _ready():
	collection_sound = $BackgroundMusic
	click_sound = $ClickSound
	collection_sound.play()

func _on_TextureButton_pressed():
	click_sound.play()

func _on_ClickSound_finished():
	get_tree().change_scene("res://scenes/Game.tscn")
