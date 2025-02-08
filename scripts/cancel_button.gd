extends Button


func _ready() -> void:
	SignalBus.move_select_card.connect(_on_move_select_card)
	self.pressed.connect(func ():
		SignalBus.cancel_button_pressed.emit()
		self.visible = false
		)


func _on_move_select_card(selecting_card: String):
	self.visible = true
