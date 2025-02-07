class_name Move # do we need extends Node here?

var name: String
var description: String
# var effects := [] # Should be populated with Effects
var uses: int = -1 # -1 is the value for infinite uses


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
