extends Node2D

@export var player_scene: PackedScene
@export var player_ammount = 0

var spawned_players = 0
var spawn_offset = Vector2(50, 50)


func _ready():
	$SpawnTimer.start()

func _on_spawner_timer_timeout():
	if spawned_players >= player_ammount:
		$SpawnTimer.stop()
		return
	
	var player = player_scene.instantiate()
	player.position += spawn_offset
	spawned_players += 1
	add_child(player)
