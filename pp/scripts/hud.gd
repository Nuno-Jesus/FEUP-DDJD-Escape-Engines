extends CanvasLayer

# CONSTANTS
@export var neededPlayers = 8
const red = Color(1.0, 0.0, 0.0, 1.0)
const green = Color(0.0, 0.5, 0.0, 1.0)

var powerupsState = {
	"Eletrical": false,
	"Mechanical": false,
	"Physical_Shrink": false,
	"Physical_Expand": false
}

@export var powerupsCount = {
	"Eletrical": 1,
	"Mechanical": 3,
	"Physical_Shrink": 1,
	"Physical_Expand": 1
}

var time_elapsed: float = 0 #

var currPlayerCount : int = 0
var finishedPlayerCount : int = 0
var deathPlayerCount : int = 0

var currPowerUp = null # Will have format: Macros.PowerUp.X
var currPowerUpName = null # Will have format: "Eletrical, ..."

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCount/InScene.text = "00"
	$PlayerCount/Needed.text = _format_number(neededPlayers)
	$PlayerCount/Dead.text = "00"

	# Change text color to red
	$PlayerCount/Finished.set("theme_override_colors/font_color", red)

	$Time/Timer.stop()

	currPowerUp = null

	_set_powerup_count()

func _updatePlayers(playerCount):
	currPlayerCount = playerCount
	$PlayerCount/InScene.text = _format_number(playerCount)

func _updateFinishedPlayers():
	finishedPlayerCount += 1
	$PlayerCount/Finished.text = _format_number(finishedPlayerCount)

	currPlayerCount -= 1
	$PlayerCount/InScene.text = _format_number(currPlayerCount)

	if finishedPlayerCount == neededPlayers:
		$PlayerCount/Finished.set("theme_override_colors/font_color", green)
		
	# END GAME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Time/Timer.is_stopped():
		return
	time_elapsed += delta

	# Update time label
	_updateTimeLabel()

func _updateTimeLabel():
	$Time/TimeString.text = _format_time(time_elapsed)

func _format_number(num: int) -> String:
	if num >= 0 and num < 10:
		return "0" + str(num)
	else:
		return str(num)

func _format_time(time: float) -> String:
	var mins = int(time) / 60
	time -= mins * 60
	var secs = int(time)

	return _format_number(mins) + ":" + _format_number(secs)

# only 1 powerup can be active at a time
func _on_PowerupButton_pressed(button: TextureButton, state: bool):	
	var powerup = button.name
	
	print("Powerup: ", powerup)

	# turn off any powerup that might be on
	for key in powerupsState:
		if powerupsState[key]:
			powerupsState[key] = false
			_force_turn_off_powerup(key)

	# set the current to true only if it was turned on
	if state:
		powerupsState[powerup] = true
		_set_current_powerup(powerup)
		currPowerUpName = powerup
	else:
		currPowerUp = null
		currPowerUpName = null

func _force_turn_off_powerup(powerup: String):
	var button = get_node(powerup).get_node(powerup)
	button.button_pressed = false

func _set_current_powerup(powerUpName: String):
	match powerUpName:
		"Eletrical":
			currPowerUp = Macros.PowerUp.ELETRICAL
		"Mechanical":
			currPowerUp = Macros.PowerUp.MECHANICAL
		"Physical_Shrink":
			currPowerUp = Macros.PowerUp.PHYSICAL_SHRINK
		"Physical_Expand":
			currPowerUp = Macros.PowerUp.PHYSICAL_EXPAND

func _set_powerup_count():
	for p in powerupsCount:
		var node = get_node(p)
		node._setCount(powerupsCount[p])

func _decrease_powerup_count():
	var currentButtonNode = get_node(NodePath(currPowerUpName))

	# decrease powerup count
	if powerupsCount[currPowerUpName] > 0:
		powerupsCount[currPowerUpName] -= 1

	# decrement the count
	currentButtonNode._decrementCount()

	# if the count is 0, set its texture to disabled
	if powerupsCount[currPowerUpName] == 0:
		var button = currentButtonNode.get_node(NodePath(currPowerUpName))
		button.disabled = true
		currPowerUp = null

func _decrease_player_count():
	currPlayerCount -= 1
	$PlayerCount/InScene.text = _format_number(currPlayerCount)
	
	deathPlayerCount+=1
	$PlayerCount/Dead.text = _format_number(deathPlayerCount)

func _get_needed_players():
	return neededPlayers
