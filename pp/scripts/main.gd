extends Node

var cursor = preload("res://art/cursor/mouse.png")

func _ready():
	pass

func _on_start_button_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_start_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton&&event.pressed:
		$ColorRect.visible = false
		$StartButton.visible = false
		$StartButton/Label.visible = false
		$ColorRect.visible = false
		
		$HUD/Time/Timer.start()
		$Level/Spawner.start()
