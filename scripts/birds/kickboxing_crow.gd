extends Card

var Moves = load("res://scripts/moves.gd")

func _ready() -> void:
	card_name = "Kickboxing Crow"
	artwork_path = "res://images/kickboxing_crow_display.png"
	health = 8
	type = [Types.SUMO, Types.AWESOME]
	moves = [
		Moves.g_single_target.new("Mega Kick", 4),
		Moves.roundhouse_kick.new(),
		Moves.g_single_target.new("Uppercut Kick", 8, 1)
	]
	
	super._ready() # Required for parent Card instantiation func to run, but could be unnecessary

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
