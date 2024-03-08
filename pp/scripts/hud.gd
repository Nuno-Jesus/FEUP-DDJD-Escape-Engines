extends CanvasLayer

var currPlayerCount = 0
var finishedPlayerCount = 0
const neededPlayers = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCount/InScene.text = "00"
	$PlayerCount/Needed.text = "/ 0" + str(neededPlayers)

func _format_number(num: int) -> String:
	if num >= 0 and num < 10:
		return "0" + str(num)
	else:
		return str(num)

func _updatePlayers(playerCount):
	$PlayerCount/InScene.text = _format_number(playerCount)

func _updateFinishedPlayers():
	finishedPlayerCount += 1
	$PlayerCount/Finished.text = _format_number(finishedPlayerCount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

