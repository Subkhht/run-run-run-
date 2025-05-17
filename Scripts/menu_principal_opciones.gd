extends Control

@onready var resolucion: Button = $VBoxContainer/resolucion
@onready var mensaje_flotante: Label = $VBoxContainer/mensaje_flotante

func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal.tscn")

func _on_volumen_pressed() -> void:
	get_tree().change_scene_to_file("res://volumen.tscn")

func _ready():
	mensaje_flotante.hide() # Asegura que esté oculto al inicio
	resolucion.pressed.connect(mostrar_mensaje)

func mostrar_mensaje():
	# Posiciona el mensaje encima del botón (ajustable)
	mensaje_flotante.position = resolucion.position + Vector2(0, -50)
	
	# Reinicia opacidad y muestra el mensaje
	mensaje_flotante.modulate = Color(1, 1, 1, 1)
	mensaje_flotante.show()
	
	# Iniciar animación de desvanecimiento tras 2 segundos
	await get_tree().create_timer(2.0).timeout
	
	# Desvanecer el mensaje
	var tween = create_tween()
	tween.tween_property(mensaje_flotante, "modulate:a", 0.0, 0.5)
	tween.finished.connect(fade_out_terminado)
	tween.play()

# Se llama automáticamente al terminar el tween
func fade_out_terminado():
	mensaje_flotante.hide()
