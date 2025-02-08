class_name Move # do we need extends Node here?

var name: String
var description: String
# var effects := [] # Should be populated with Effects
var uses: int = -1 # leave as -1 for infinite-use moves


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

func use_move() -> bool: # A function for checking if a move has uses left, and decrementing the count.
	if uses != 0: # A positive starting value can become 0, allowing them to be stopped. a negative value will never become 0, allowing them to be infinite.
		uses -=1
		return true
	else:
		return false
