extends Node2D


func _on_area_2d_body_entered(body):
	$AnimatedSprite2D.animation = "opening"
	$AnimatedSprite2D.play()
	print("Player entered door")
	

func _on_area_2d_body_exited(body):
	$AnimatedSprite2D.animation = "closing"
	$AnimatedSprite2D.play()
	print("Player exited door")
