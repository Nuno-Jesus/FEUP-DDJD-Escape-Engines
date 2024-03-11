class_name Player
extends CharacterBody2D

var cursor = preload("res://art/cursor/onPlayer.png")

var screen_size
var direction = Macros.Direction.RIGHT

var currPowerUp = null

var isStuck: bool = false
var hud_node

var animations = {
	null: {
		"walk": "walk",
		"fall": "fall"
	},
	Macros.PowerUp.ELETRICAL: {
		"walk": "eletric_walk",
		"fall": "eletric_fall"
	},
	Macros.PowerUp.MECHANICAL: {
		"walk": "mechanical_walk",
		"fall": "mechanical_fall"
	},
}

@export var speed = 0
@export var gravity = 5

func _ready():
	screen_size = get_viewport_rect().size
	hud_node = get_parent().get_parent().get_node("HUD")
	
	Signals.connect("eletric_door_spotted_engineer", _on_trying_to_fix_door)
	Signals.connect("eletric_door_is_fixed", _on_stopping_fixing_door)
	Signals.connect("platform_spotted_engineer", _on_trying_to_activate_gear)

func _on_trying_to_fix_door(name, door_name):
	if name != self.name:
		return
	if currPowerUp != Macros.PowerUp.ELETRICAL:
		return
		
	set_physics_process(false)
	$AnimatedSprite2D.play("eletric_fix")
	Signals.emit_signal("eletric_door_is_being_fixed", door_name)

func _on_stopping_fixing_door(name):
	if name != self.name:
		return
		
	currPowerUp = null
	set_physics_process(true)

func _physics_process(delta):
	velocity.y += gravity
	velocity.x = direction * speed

	move_and_slide()
	
	var falling_animation = animations[currPowerUp]["fall"]
	var walking_animation = animations[currPowerUp]["walk"]
	
	if velocity.y > gravity:
		$AnimatedSprite2D.play(falling_animation)
	else:
		$AnimatedSprite2D.play(walking_animation)
		
	if is_on_wall():
		direction = -direction
		$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
		

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton&&event.pressed:
		if isStuck or hud_node.currPowerUp == null:
			return

		match currPowerUp:
			Macros.PowerUp.PHYSICAL_SHRINK:
				$PowerUpsTimer.stop()
				$PowerUpsTimer.start()
				$AnimationPlayer.play("shrink")
			Macros.PowerUp.PHYSICAL_EXPAND:
				$PowerUpsTimer.stop()
				$PowerUpsTimer.start()
				$AnimationPlayer.play("expand")

		currPowerUp = hud_node.currPowerUp
		print("Current powerup: ", currPowerUp)
		hud_node._decrease_powerup_count()

func _on_trying_to_activate_gear(name):	
	if name != self.name:
		return
	if currPowerUp != Macros.PowerUp.MECHANICAL:
		return
	
	set_physics_process(false)
	$AnimatedSprite2D.play("mechanical_idle")
	Signals.emit_signal("platform_body_is_mechanical", "null")

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))

func _on_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _on_power_ups_timer_timeout():
	if isStuck and currPowerUp == Macros.PowerUp.PHYSICAL_SHRINK:
		$PowerUpsTimer.start(0.1)
		return
	currPowerUp = null
	$AnimationPlayer.play_backwards()

func _on_area_2d_body_entered(body):
	isStuck = true
	
func _on_area_2d_body_exited(body):
	isStuck = false
