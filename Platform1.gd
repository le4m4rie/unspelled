extends StaticBody2D

func _ready():
	modulate = Color(255, 255, 255, 0.8)
	
func _process(delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
