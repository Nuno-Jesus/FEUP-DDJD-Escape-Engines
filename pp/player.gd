extends CharacterBody2D

enum Direction { LEFT = -1, RIGHT = 1 }

var screen_size
var direction = Direction.RIGHT

@export var gravity = 1
@export var speed = 70

func _ready():
	screen_size = get_viewport_rect().size
	velocity.x = speed
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	velocity.y += gravity
	velocity.x = direction * speed
	
	if position.x > screen_size.x:
		direction = Direction.LEFT
		$AnimatedSprite2D.flip_h = true
	if position.x < 0:
		direction = Direction.RIGHT
		$AnimatedSprite2D.flip_h = false
		
	move_and_slide()

## Check if the player has been clicked on
#func _on_RigidBody2D_input_event( viewport: Node, event: InputEvent, shape_idx: int ):
	#if (event is InputEventMouseButton && event.pressed):
		#print("Clicked")
	


# On top of the platform
func _on_area_2d_area_entered(area):
	print("I'm on top of the platfrom\n")
	pass # Replace with function body.
