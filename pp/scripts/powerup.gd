extends Node

var hud_node
var button

# Called when the node enters the scene tree for the first time.
func _ready():
	hud_node = get_parent()
	button = get_child(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_texture_button_toggled(toggled_on):
	if toggled_on:
		hud_node._on_PowerupButton_pressed(button, toggled_on)
