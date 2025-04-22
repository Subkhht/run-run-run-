extends TextureRect

@export var player: Player  # Exporta la variable 'player' para asignarla desde el editor.

func _ready() -> void:
	# Verifica que 'player' sea de tipo Player.
	assert(player is Player)  
	# Asigna la posición X de este nodo como la meta del jugador.
	player.finish_x = global_position.x  
