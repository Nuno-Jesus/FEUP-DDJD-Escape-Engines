extends Node

var hud_node
var button

var count
var cursor = preload("res://art/cursor/mouse.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	hud_node = get_parent()
	button = get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_button_toggled(toggled_on):
	if count < 1:
		return
	
	hud_node._on_PowerupButton_pressed(button, toggled_on)

func _setCount(newCount: int):
	count = newCount
	$Count.text = str(count)

func _decrementCount():
	count -= 1
	$Count.text = str(count)

func _getCount() -> int:
	return count

func _on_mouse_entered():
	if count >= 1:
		Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(null)
