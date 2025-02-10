extends Area2D


var parent_card: String

func _on_mouse_entered() -> void:
	if $'Border'.visible:
		$'Background'.visible = true

func _on_mouse_exited() -> void:
	if $'Border'.visible and $'Background'.visible:
		$'Background'.visible = false

func _on_move_select_card(selecting_card: String) -> void:
	if selecting_card == parent_card:
		return
	
	$'Border'.visible = true
	
func _on_cancel_button_pressed() -> void:
	$'Border'.visible = false

func _on_card_chosen(chosen_card: String) -> void:
	print('card chosen! ~ ' + chosen_card)
	$'Border'.visible = false
	$'Background'.visible = false
	
func _ready() -> void:
	# Set up signals
	SignalBus.move_select_card.connect(_on_move_select_card)
	SignalBus.cancel_button_pressed.connect(_on_cancel_button_pressed)
	SignalBus.card_chosen.connect(_on_card_chosen)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	parent_card = get_parent().name

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and $'Background'.visible:
		SignalBus.card_chosen.emit(parent_card)
