class mega_kick extends Move:
	func _init() -> void:
		name = "Mega Kick"
		super()

	func run_effect() -> void:
		print("hello!")

class roundhouse_kick extends Move:
	func _init() -> void:
		name = "Roundhouse Kick"
		super()

	func run_effect() -> void:
		print("hello!")

class uppercut_kick extends Move:
	func _init() -> void:
		name = "Uppercut Kick"
		super()

	func run_effect() -> void:
		print("hello!")

class g_single_target extends Move:
	var damage: int
	
	func _init(mv_name: String, mv_damage: int, starting_uses: int = -1) -> void:
		name = mv_name
		uses = starting_uses
		damage = mv_damage
		super()
	
	func run_effect() -> void:
		if use_move(): # Just to make sure there are uses left
			print(damage)
