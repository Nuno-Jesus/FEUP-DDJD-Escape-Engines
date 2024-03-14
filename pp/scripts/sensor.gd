extends Node2D

@export var neededPlayers = 8

var playersCrossed = 0


func _ready():
	$Label.text = str(neededPlayers)
	$Sensor.play()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		playersCrossed += 1
	
	if (neededPlayers - playersCrossed) <= 0:
		$Label.text = "0"
		$Area2D/CollisionShape2D.disabled = true
		$Gate/Path2D/AnimationPlayer.play("close")
	else:
		$Label.text = str(neededPlayers - playersCrossed)
	
	print(playersCrossed, " have crossed the sensor")
	
