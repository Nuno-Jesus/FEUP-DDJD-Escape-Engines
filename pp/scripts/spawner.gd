extends Node2D

@export var player_scene: PackedScene
@export var player_ammount = 0

var spawned_players = 0

var main_node
var hud_node

func _ready():
	main_node = get_parent().get_parent()
	Signals.connect("hud_loaded", _on_hud_loaded)
	$SpawnTimer.stop()

func _on_hud_loaded():
	hud_node = main_node.get_node("HUD")
	
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
	player.position = self.position
	spawned_players += 1
	
	# update HUD
	hud_node._updatePlayers(spawned_players)
	
	get_parent().add_child(player)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shrink":
		queue_free()
