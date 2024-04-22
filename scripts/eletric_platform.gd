extends Node2D

var fixer_name: String = ""
var isFixed: bool = false
var isBeingFixed: bool = false

func _ready():
	Signals.connect("eletric_door_is_being_fixed", _on_fix)


func _on_area_2d_body_entered(body):
	if !body.is_in_group("Player") or isFixed or isBeingFixed:
		return
	fixer_name = body.name
	Signals.emit_signal("eletric_door_spotted_engineer", fixer_name, self.name)
		
	
func _on_fix(name):
	if name != self.name:
		return
	isBeingFixed = true
	print("%s is being fixed!" % name)
	$Timer.start(3.0)
	

func _on_timer_timeout():
	print("%s is fixed!" % self.name)
	isFixed = true
	$AnimationPlayer.play("lifting")
	Signals.emit_signal("eletric_door_is_fixed", fixer_name)
