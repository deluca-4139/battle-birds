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
var artwork_path: String

func construct_button(move: Move, x: float, y: float) -> Button:
	var move_button = Button.new()
	move_button.text = move.name
	move_button.position = Vector2(x, y)
	move_button.pressed.connect(
		func (): 
			SignalBus.move_select_card.emit(self.name)
			)
	add_child(move_button)
	return move_button # unnecessary?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up signals
	SignalBus.move_select_card.connect(_on_move_select_card)
	SignalBus.cancel_button_pressed.connect(_on_cancel_button_pressed)
	
	# Set up artwork
	$Artwork.texture = load(artwork_path)
	$Artwork.scale = Vector2(0.1, 0.11) # how do we determine this programatically? how do we scale sprite separately from region?
	#$Artwork.region_rect = Rect2(0, 0, 205, 144) # don't forget to enable region in inspector
	
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
	
func _on_move_select_card(selecting_card: String) -> void:
	if selecting_card == self.name:
		return
	
	$'Card Selection Border'.visible = true
	
func _on_cancel_button_pressed() -> void:
	$'Card Selection Border'.visible = false
