extends Camera2D

var zoom_direction = {
	"in" : Vector2(1, 1),
	"out" : Vector2(-1, -1)
}

var zoom_min = Vector2(0.8001, 0.8001)
var zoom_max = Vector2(2 ,2)
var zoom_speed = Vector2(0.2, 0.2)
var des_zoom = zoom

func _process(_delta):
	#zoom = lerp(zoom, des_zoom, .2)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			print("Zoom: ", zoom)
			var mouse_position = event.position

			# zooming out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					_zoom_at_point(zoom_direction.out)

			# zooming in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					_zoom_at_point(zoom_direction.in)

func _zoom_at_point(direction):
	var previous_mouse_position := get_local_mouse_position()
	var new_zoom = zoom + (zoom * zoom_speed * direction)

	# check for zooming out above the minimum zoom
	if direction == zoom_direction.out:
		print("I'm zooming out, and the new zoom is: ", new_zoom)

		if new_zoom > zoom_min:
			des_zoom = new_zoom
		else:
			des_zoom = zoom_min
			
	# check for zooming in below the maximum zoom
	if direction == zoom_direction.in:
		if new_zoom < zoom_max:
			des_zoom = new_zoom
		else:
			des_zoom = zoom_max


	var diff = previous_mouse_position - get_local_mouse_position()
	offset += diff
