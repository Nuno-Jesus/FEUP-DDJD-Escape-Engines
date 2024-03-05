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
