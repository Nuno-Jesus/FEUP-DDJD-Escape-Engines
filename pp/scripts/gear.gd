extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# $AnimationPlayer.play("rotate")
	pass # Replace with function body.

# Called when the player is on top of the "button" that is going to rotate the platform
# todo: connect the signal from the button to this function
func _startRotation():
	$AnimationPlayer.play("rotate")

# Called when the signal "area_exited (or similar)" is emitted from the "button" that is going to rotate the platform
# todo: connect the signal from the button to this function
func _stopRotation():
	$AnimationPlayer.stop(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_entry_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		Signals.emit_signal("gear_spotted_engineer", body.name)

func _on_entry_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		Signals.emit_signal("gear_exiting_engineer", body.name)

