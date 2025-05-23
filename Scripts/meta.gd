extends TextureRect

@onready var player: Player = $"../Player" # Referencia al Player
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer" # Referencia al Audio

func _ready() -> void:
	# Verifica que 'player' sea de tipo Player.
	assert(player is Player)  
	# Asigna la posición X de este nodo como la meta del jugador.
	player.finish_x = global_position.x 
	 
# _process(delta) se ejecuta en cada fotograma para verificar si el jugador llegó a la meta.
func _process(delta: float) -> void:
	# Si el jugador ha alcanzado o superado la meta, detén el audio.
	if player.global_position.x >= player.finish_x:
		get_tree().change_scene_to_file("res://menu_seleccion.tscn") # Vuelve al menu de selecionar nivel
