extends CanvasLayer

var currPlayerCount = 0
var curr_player_count_node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCount/InScene.text =  "00"
	curr_player_count_node = get_node("PlayerCount").get_node("Count")

func _updatePlayers(playerCount):
	currPlayerCount = str(playerCount)

	# add leading 0s if less than 10 players
	if playerCount < 10:
		currPlayerCount = "0" + currPlayerCount

	$PlayerCount/InScene.text = currPlayerCount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
