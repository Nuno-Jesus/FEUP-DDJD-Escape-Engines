extends Node2D

@export var neededPlayers = 8

var playersCrossed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(neededPlayers)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		playersCrossed+=1
	
	if (neededPlayers - playersCrossed) < 0:
		$Label.text = "0"	
	else:
		$Label.text = str(neededPlayers - playersCrossed)
	
	print(playersCrossed, " have crossed the sensor")
	
