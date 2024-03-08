extends Node2D

var isOpen: bool = false
var hudNode
var mainNode
	
func _ready():
	mainNode = get_parent().get_parent()
	hudNode = mainNode.get_node("HUD")

func _on_animation_area_body_entered(body):
	if body.name.left(8) != "Engineer":
		return
	if !isOpen:
		$AnimatedSprite2D.play("opening")
		isOpen = true
	else:	
		$CloseAnimationTimer.start()
	
func _on_remove_player_area_body_entered(body):
	if body.name.left(8) != "Engineer":
		return
	body.queue_free()
	
	# update finished player count
	hudNode._updateFinishedPlayers()

func _on_close_animation_timer_timeout():
	if isOpen:
		$AnimatedSprite2D.play("closing")
		isOpen = false
