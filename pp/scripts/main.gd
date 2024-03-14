extends Node

var cursor = preload("res://art/cursor/mouse.png")
var isNewGameInstance : bool = false

@export var hud_scene : PackedScene
@export var level_scene : PackedScene

func _ready():
	Signals.connect("end_game", _on_end_game)

func _on_start_button_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_start_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _start_game():
	$ColorRect.visible = false
	$StartButton.visible = false
	$StartButton/Label.visible = false
	$StartButton/DecorationSprites.visible = false
	$ColorRect.visible = false
		
	$HUD/Time/Timer.start()
	$Level/Spawner.start()
	
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton&&event.pressed:
		if isNewGameInstance:
			get_tree().reload_current_scene()
		
		_start_game()

func _on_end_game():
	isNewGameInstance = true

	$ColorRect.visible = true
	$StartButton.visible = true
	$StartButton/Label.visible = true
	$StartButton/DecorationSprites.visible = true
	$StartButton/Label.text = "Restart Game"
	$ColorRect.visible = true
