extends Camera2D


var zoom_min = Vector2(0.8001, 0.8001)
var zoom_max = Vector2(2 ,2)
var zoom_speed = Vector2(.2, .2)
var des_zoom = zoom

func _process(_delta):
	zoom = lerp(zoom, des_zoom, .2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom > zoom_min:
					if ((des_zoom - zoom_speed) > zoom_min):
						des_zoom -= zoom_speed
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom < zoom_max:
					des_zoom += zoom_speed
