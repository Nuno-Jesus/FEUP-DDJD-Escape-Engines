extends RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Check if the player has been clicked on
func _on_RigidBody2D_input_event( viewport: Node, event: InputEvent, shape_idx: int ):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")
	

