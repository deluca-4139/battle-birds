extends Card

var Moves = load("res://scripts/moves.gd")

func _ready() -> void:
	card_name = "Kickboxing Crow"
	health = 8
	type = [Types.SUMO, Types.AWESOME]
	moves = [
		Moves.mega_kick.new(),
		Moves.roundhouse_kick.new(),
		Moves.uppercut_kick.new()
	]
	
	super._ready() # Required for parent Card instantiation func to run, but could be unnecessary

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
