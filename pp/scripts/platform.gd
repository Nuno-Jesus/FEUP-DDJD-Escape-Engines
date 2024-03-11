extends StaticBody2D

#@export var gear_scene: PackedScene

var parent_node
var gear_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	gear_node = parent_node.get_node("Gear")
	Signals.connect("platform_body_is_mechanical", _on_activate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	# If the body is a player
	if body.is_in_group("Player"):
		Signals.emit_signal("platform_spotted_engineer", body.name)

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass

func _on_activate(_name):
	gear_node._startRotation()
