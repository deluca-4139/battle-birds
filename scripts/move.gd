class_name Move # do we need extends Node here?

var name: String
var description: String
# var effects := [] # Should be populated with Effects
var is_single_use: bool = false
var has_been_used: bool = false # Only relevant if is_single_use is true; is there a better way to do this?


func _init() -> void: 
	pass

func run_effect() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
