extends StaticBody2D

#@export var gear_scene: PackedScene

var parent_node
var gear_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()
	gear_node = parent_node.get_node("Gear")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_name().begins_with("Engineer")):
		gear_node._startRotation()

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_name() == "Engineer"):
		gear_node._stopRotation()
