extends Node

var cursor = preload ("res://art/cursor/mouse.png")
var isNewGameInstance: bool = false

@export var hud_scene: PackedScene
@export var level_scene: PackedScene

var new_hud
var new_lvl
var paused : bool = false

func _ready():
	Signals.connect("end_game", _on_end_game)

func _on_start_button_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_start_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _start_game():
	_unset_button()

	if isNewGameInstance:
		# remove old nodes
		get_node("Level").free()

		new_lvl = level_scene.instantiate()
		new_lvl.name = "Level"
		add_child(new_lvl, true)

	new_hud = hud_scene.instantiate()
	add_child(new_hud, true)
	new_hud.name = "HUD"
	_set_correct_powerups()
	
	Signals.emit_signal("hud_loaded")

	get_node("HUD/Time/Timer").start()
	get_node("Level/Spawner").start()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left_click"):
		if paused:
			get_tree().paused = false
			_unset_button()
		else:
			_start_game()

func _on_end_game():
	isNewGameInstance = true

	_set_button("Restart Game")

	# Stop timers (updates)
	$HUD/Time/Timer.stop()
	$Level/Spawner/SpawnTimer.stop()
	
	$HUD.free()

func _input(event):
	# Click on "R"
	if event.is_action_pressed("restart"):
		_on_end_game()
		_start_game()
	
	# Click on "P"
	if event.is_action_pressed("pause"):
		_set_button("Resume Game")
		get_tree().paused = true
		paused = true
			
func _set_correct_powerups():
	get_node("HUD").powerupsCount = {
		"Eletrical": 4,
		"Mechanical": 2,
		"Physical_Shrink": 3,
		"Physical_Expand": 3
	}

func _set_button(text : String):
	$ColorRect.visible = true
	$StartButton.visible = true
	$StartButton/Label.visible = true
	$StartButton/DecorationSprites.visible = true
	$StartButton/Label.text = text
	$ColorRect.visible = true

func _unset_button():
	$ColorRect.visible = false
	$StartButton.visible = false
	$StartButton/Label.visible = false
	$StartButton/DecorationSprites.visible = false
	$ColorRect.visible = false
