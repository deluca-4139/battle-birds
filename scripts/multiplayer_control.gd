extends Control

# These signals can be connected to by a UI lobby scene or the game scene.
signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

const PORT = 1337
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 20

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}

# This is the local player info. This should be modified locally
# before the connection is made. It will be passed to every other peer.
# For example, the value of "name" can be set to something the player
# entered in a UI scene.
var player_info = {"name": "Name"}

var players_loaded = 0

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene # Possible needed?

# ID should eventually be updated to match
# some specification that can be documented
func add_player(id: int = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	player_connected.emit(1, player_info)

func _on_host_button_pressed():
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	$"Start Button".visible = true
	add_player()

func _on_join_button_pressed(address = ""):
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	var error = peer.create_client(address, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
func _on_start_button_pressed() -> void:
	if multiplayer.is_server():
		start_game.rpc()



func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)





## When the server decides to start the game from a UI scene,
## do Lobby.load_game.rpc(filepath)
#@rpc("call_local", "reliable")
#func load_game(game_scene_path):
	#get_tree().change_scene_to_file(game_scene_path)
#
#
## Every peer will call this when they have loaded the game scene.
#@rpc("any_peer", "call_local", "reliable")
#func player_loaded():
	#if multiplayer.is_server():
		#players_loaded += 1
		##if players_loaded == players.size():
			##$/root/Game.start_game()
			##players_loaded = 0


# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	print("joined! ~ " + str(id))
	_register_player.rpc_id(id, player_info)


@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)
	
@rpc("any_peer", "reliable")
func start_game():
	print("woag! " + str(multiplayer.get_remote_sender_id()))

func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null

func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)
	print("oh noag")


func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)


func _on_connected_fail():
	multiplayer.multiplayer_peer = null


func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()
