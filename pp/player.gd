extends RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Check if the player has been clicked on
func _on_RigidBody2D_input_event( viewport: Node, event: InputEvent, shape_idx: int ):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")
	


# On top of the platform
func _on_area_2d_area_entered(area):
	print("I'm on top of the platfrom\n")
	pass # Replace with function body.
