extends Node2D

@export var player_scene: PackedScene
@export var player_ammount = 10

var spawned_players = 0
var spawn_offset = Vector2(0, 0)


func _ready():
	$SpawnTimer.start()


func _process(delta):
	pass


func _on_spawner_timer_timeout():
	if spawned_players >= player_ammount:
		$SpawnTimer.stop()
		return
	
	var player = player_scene.instantiate()
	player.position = self.position
	spawned_players += 1
	add_child(player)
