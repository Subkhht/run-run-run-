class_name DangerZone extends StaticBody2D

@export var player: Player  # Variable exportada para asignar el nodo del jugador en el inspector

func _ready():
	# Verificar si la variable player está asignada
	if not player:
		push_error("Error: La variable 'player' no está asignada. Asigna el jugador en el inspector.")
		return
	
	print("Jugador asignado correctamente: ", player.name)
	
	# Conectar la señal 'body_shape_entered'
	connect("body_shape_entered", Callable(self, "_on_body_shape_entered"))

func _on_body_shape_entered(body_id: int, body: Node, body_shape_index: int, local_shape_index: int):
	print("Colisión detectada con el cuerpo: ", body.name)
	
	# Verificar si el cuerpo que entra pertenece al grupo 'player'
	if body.is_in_group("player"):
		print("Jugador chocó con superficie peligrosa. Reiniciando nivel...")
		get_tree().reload_current_scene()
	else:
		print("El cuerpo no pertenece al grupo 'player'.")
