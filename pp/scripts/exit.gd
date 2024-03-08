extends Node2D

var isOpen: bool = false

func _on_animation_area_body_entered(body):
	if body.name.left(8) != "Engineer":
		return
	if !isOpen:
		$AnimatedSprite2D.play("opening")
		isOpen = true
	else:	
		$CloseAnimationTimer.start()
		
func _process(_delta):
	print($CloseAnimationTimer.wait_time)
	
func _on_remove_player_area_body_entered(body):
	if body.name.left(8) != "Engineer":
		return
	body.queue_free()

func _on_close_animation_timer_timeout():
	if isOpen:
		$AnimatedSprite2D.play("closing")
		isOpen = false
