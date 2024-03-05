extends CharacterBody2D

enum Direction { LEFT = -1, RIGHT = 1 }

var screen_size
var direction = Direction.RIGHT

@export var gravity = 1
@export var speed = 0

func _ready():
	screen_size = get_viewport_rect().size
	velocity.x = speed
	$AnimatedSprite2D.play()

func _physics_process(delta):
	velocity.y += gravity
	velocity.x = direction * speed
	
	move_and_slide()
	
	if position.x > screen_size.x:
		direction = Direction.LEFT
		$AnimatedSprite2D.flip_h = true
	if position.x < 0:
		direction = Direction.RIGHT
		$AnimatedSprite2D.flip_h = false


func _on_input_event(viewport, event, shape_idx):
	## Check if the player has been clicked on
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")


# On top of the platform
func _on_area_2d_area_entered(area):
	print("I'm on top of the platfrom\n")
	pass # Replace with function body.

