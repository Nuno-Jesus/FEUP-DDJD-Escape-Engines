extends Node2D

var isOpen: bool = false
var hudNode
var mainNode
var finishedPlayers : int = 0
	
func _ready():
	mainNode = get_parent().get_parent()
	Signals.connect("hud_loaded", _on_hud_loaded)
	
	$AnimatedSprite2D.play("default")

func _on_hud_loaded():
	hudNode = mainNode.get_node("HUD")
	
func _on_remove_player_area_body_entered(body):
	if !body.is_in_group("Player"):
		return
	body.queue_free()
	
	finishedPlayers+=1
	
	if finishedPlayers == hudNode._get_needed_players():
		Signals.emit_signal("end_game")
	
	# update finished player count
	hudNode._updateFinishedPlayers()
