@tool
extends Control

# Rango de volumen: 0.0 a 1.0 (0% a 100%)
var volume_level: float = 1.0
const VOLUME_STEP := 0.05

@onready var volume_label = $VolumeLabel
@onready var volume_down_button = $VolumeDownButton
@onready var volume_up_button = $VolumeUpButton

func _ready():
	update_volume_label()
	volume_down_button.pressed.connect(decrease_volume)
	volume_up_button.pressed.connect(increase_volume)

func decrease_volume():
	volume_level -= VOLUME_STEP
	if volume_level < 0.0:
		volume_level = 0.0
	AudioServer.set_bus_volume_db(0, linear_to_db(volume_level))
	update_volume_label()

func increase_volume():
	volume_level += VOLUME_STEP
	if volume_level > 1.0:
		volume_level = 1.0
	AudioServer.set_bus_volume_db(0, linear_to_db(volume_level))
	update_volume_label()

func update_volume_label():
	var percent = int(volume_level * 100)
	volume_label.text = "Volumen: %d%%" % percent

# Función auxiliar para convertir de escala lineal a dB
func linear_to_db(value: float) -> float:
	if value <= 0:
		return -80 # Silencio absoluto
	return 20 * (log(value) / log(10))
	
func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal_opciones.tscn")
