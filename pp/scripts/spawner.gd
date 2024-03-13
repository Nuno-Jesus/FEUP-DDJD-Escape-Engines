class_name Spawner
extends Node2D

@export var player_scene: PackedScene
@export var player_ammount = 0

var spawned_players = 0
var spawn_offset = Vector2(0, 0)

var main_node
var hud_node

func _ready():
	main_node = get_parent().get_parent()
	hud_node = main_node.get_node("HUD")
	$SpawnTimer.stop()
	
func start():
	$SpawnTimer.start()
	$AnimatedSprite2D.play()
	$AnimationPlayer.play("expand")
	
func _on_spawner_timer_timeout():
	if spawned_players >= player_ammount:
		$SpawnTimer.stop()
		$AnimationPlayer.play_backwards()
		return
	
	var player = player_scene.instantiate()
	player.position += self.position + spawn_offset
	spawned_players += 1
	
	# update HUD
	hud_node._updatePlayers(spawned_players)
	
	get_parent().add_child(player)
