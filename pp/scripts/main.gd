extends Node

var cursor = preload ("res://art/cursor/mouse.png")
var isNewGameInstance: bool = false

@export var hud_scene: PackedScene
@export var level_scene: PackedScene

var new_hud
var new_lvl

func _ready():
	Signals.connect("end_game", _on_end_game)

func _on_start_button_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_start_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _start_game():
	if get_tree().paused:
		get_tree().paused = false
	
	$ColorRect.visible = false
	$StartButton.visible = false
	$StartButton/Label.visible = false
	$StartButton/DecorationSprites.visible = false
	$ColorRect.visible = false

	if isNewGameInstance:
		# remove old nodes
		#get_node("HUD").free()
		get_node("Level").free()

		# add new ones
		#new_hud = hud_scene.instantiate()
		#new_hud.name = "HUD"
		#add_child(new_hud, true)

		new_lvl = level_scene.instantiate()
		new_lvl.name = "Level"
		add_child(new_lvl, true)

	new_hud = hud_scene.instantiate()
	add_child(new_hud, true)
	new_hud.name = "HUD"
	Signals.emit_signal("hud_loaded")

	get_node("HUD/Time/Timer").start()
	get_node("Level/Spawner").start()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left_click"):
		_start_game()

func _on_end_game():
	isNewGameInstance = true

	$ColorRect.visible = true
	$StartButton.visible = true
	$StartButton/Label.visible = true
	$StartButton/DecorationSprites.visible = true
	$StartButton/Label.text = "Restart Game"
	$ColorRect.visible = true

	# Stop timers (updates)
	$HUD/Time/Timer.stop()
	$Level/Spawner/SpawnTimer.stop()
	
	get_tree().paused = true
	
	$HUD.free()

func _input(event):
	if event.is_action_pressed("restart"):
		_on_end_game()
		#_start_game()
