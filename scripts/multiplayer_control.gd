extends Node

const PORT = 1337
const DEFAULT_SERVER_IP = "127.0.0.1" # IPv4 localhost
const MAX_CONNECTIONS = 20

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}
var player_info = {"name": "Name"}

var peer = ENetMultiplayerPeer.new()
#@export var player_scene: PackedScene # Possibly unneeded?

func _complete_setup() -> void:
	multiplayer.multiplayer_peer = peer 
	$"Chat Entry".editable = true
	$"Chat Send".disabled = false

func _on_host_button_pressed():
	print("Beginning host...")
	var error = peer.create_server(PORT, MAX_CONNECTIONS)
	if error:
		return error
	_complete_setup()
	
func _on_join_button_pressed(address = ""):
	print("Beginning join...")
	if $Username.text: player_info["name"] = $Username.text
	if address.is_empty():
		address = DEFAULT_SERVER_IP
	var error = peer.create_client(address, PORT)
	if error:
		return error
	_complete_setup()

# Update connected players' databases
# when someone changes their name.
func _on_username_text_changed(new_text: String) -> void:
	# this functions but returns an
	# error nullptr; can fix?
	if not peer.host: return 
	#if not multiplayer.multiplayer_peer: return
	_register_player.rpc(new_text)

func _on_chat_send_pressed() -> void:
	send_chat_message.rpc($"Chat Entry".text)
	$"Chat Entry".clear()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# These should also hook into signals,
	# which can be linked to UI elements, etc
	multiplayer.peer_connected.connect(func(id):
		_register_player.rpc_id(id, $Username.text)
		print("Peer connected. ID: %s" % id)
	)
	multiplayer.peer_disconnected.connect(func(id):
		print("Peer disconnected. ID: %s" % id)
	)

@rpc("any_peer", "call_local", "unreliable_ordered")
func _register_player(player_data):
	print("Registering player...")
	var player_id = multiplayer.get_remote_sender_id()
	players[player_id] = player_data

@rpc("any_peer", "call_local", "unreliable_ordered")
func send_chat_message(text: String):
	var username: String
	if multiplayer.get_remote_sender_id() in players:
		username = players[multiplayer.get_remote_sender_id()]
	else:
		# This is a failsafe for a bug where the
		# client hasn't updated their name in 
		# the local database yet. 
		username = $Username.text
		players[multiplayer.get_unique_id()] = username
	
	$"Chat History".text += "(%s) %s\n" % [username, text]
