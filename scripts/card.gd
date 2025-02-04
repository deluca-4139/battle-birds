class_name Card extends Area2D # is extends necessary? idk

enum Types {
	AQUA,
	AWESOME,
	CHICK,
	EARTH,
	FLAME,
	FLIRT,
	FROST,
	FRUITY,
	GOLD,
	HUMAN,
	LEGENDARY,
	NINJA,
	RAINBOW,
	ROBOT,
	SALESMAN,
	SHAPE,
	SPOOKY,
	STANDARD,
	SUMO,
	THUNDER,
	TOXIC,
	WIND,
	WIZARD
}
	

var card_name: String
var type := [Types] # Should be populated with Types
var health: int
var moves := [Move] # Should be populated with Moves

func construct_button(move: Move, x: float, y: float) -> Button:
	var move_button = Button.new()
	move_button.text = move.name
	move_button.position = Vector2(x, y)
	move_button.pressed.connect(move.run_effect)
	add_child(move_button)
	return move_button # unnecessary?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up labels
	$"Name Label".text = card_name
	$"Health Label".text = str(health)
	
	# TODO: Set up types
	
	# Set up moves
	# These values should not be magic...
	var distance_between = 210 / len(moves)
	var y_loc = -0
	for move in moves:
		construct_button(move, -110, y_loc)
		y_loc += distance_between
	# TODO: set up damage numbers

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
