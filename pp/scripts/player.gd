class_name Player
extends CharacterBody2D

var cursor = preload("res://art/cursor/onPlayer.png")

var screen_size
var direction = Macros.Direction.RIGHT

# initially, the player has no powerups
var powerups = []
var currPowerUp = null

var isStuck: bool = false
var hud_node

@export var speed = 0
@export var gravity = 5

func _ready():
	screen_size = get_viewport_rect().size
	Signals.connect("eletric_door_spotted_engineer", _on_trying_to_fix_door)
	Signals.connect("eletric_door_is_fixed", _on_stopping_fixing_door)
	
	Signals.connect("platform_spotted_engineer", _on_trying_to_activate_gear)
	
	velocity.x = speed
	$AnimatedSprite2D.play()

	hud_node = get_parent().get_parent().get_node("HUD")

func _on_trying_to_fix_door(name, door_name):
	if name != self.name:
		return
	if !powerups.has(Macros.PowerUp.ELETRICAL):
		return
	velocity.x = 0
	set_physics_process(false)
	$AnimatedSprite2D.play("busy")
	Signals.emit_signal("eletric_door_is_being_fixed", door_name)

func _on_stopping_fixing_door(name):
	if name != self.name:
		return
	$AnimatedSprite2D.play("walk")
	set_physics_process(true)
	powerups.clear()

func _physics_process(delta):
	velocity.y += gravity
	velocity.x = direction * speed

	move_and_slide()
	if velocity.y > gravity:
		$AnimatedSprite2D.play("fall")
	else:
		$AnimatedSprite2D.play("walk")
		
	if is_on_wall():
		direction = -direction
		print("HIT wall with speed: ", velocity)
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton&&event.pressed:
		if isStuck or hud_node.currPowerUp == null:
			return

		currPowerUp = hud_node.currPowerUp
		print("Current powerup: ", currPowerUp)

		match currPowerUp:
			Macros.PowerUp.CHEMICAL:
				$PowerUpsTimer.stop()
				$PowerUpsTimer.start()
				$AnimationPlayer.play("shrink")
			Macros.PowerUp.CIVIL:
				$PowerUpsTimer.stop()
				$PowerUpsTimer.start()
				$AnimationPlayer.play("expand")

		powerups.append(currPowerUp)
		hud_node._decrease_powerup_count()

func _on_trying_to_activate_gear(name):	
	if name != self.name:
		return
	if !powerups.has(Macros.PowerUp.MECHANICAL):
		return
		
	set_physics_process(false)
	Signals.emit_signal("platform_body_is_mechanical", "null")

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _on_power_ups_timer_timeout():
	if isStuck and currPowerUp == Macros.PowerUp.CHEMICAL:
		$PowerUpsTimer.start(0.1)
		return
	currPowerUp = null
	$AnimationPlayer.play_backwards()

func _on_area_2d_body_entered(body):
	isStuck = true
	print("IM STUCK")
	
func _on_area_2d_body_exited(body):
	isStuck = false
	print("IM FREE")
