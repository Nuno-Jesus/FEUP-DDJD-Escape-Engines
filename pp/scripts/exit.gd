extends Node2D

var isOpen: bool = false
var hudNode
var mainNode
	
func _ready():
	mainNode = get_parent().get_parent()
	hudNode = mainNode.get_node("HUD")
	$AnimatedSprite2D.play("default")
	
func _on_remove_player_area_body_entered(body):
	if !body.is_in_group("Player"):
		return
	body.queue_free()
	
	# update finished player count
	hudNode._updateFinishedPlayers()
