class_name Player extends CharacterBody2D

# Exporta variables ajustables desde el editor.
@export var up_gravity = 250  # Gravedad hacia arriba.
@export var down_gravity = 300  # Gravedad hacia abajo.
@export var jump_force = 190  # Fuerza del salto.
@export var unjump_force = 20  # Fuerza al soltar el botón de salto.
@export var aceleracion = 150  # Aceleración horizontal.
@export var max_speed = 300  # Velocidad máxima.
@export var friccion = 210  # Fricción en el suelo.
@export var air_friccion = 50  # Fricción en el aire.
@export var landing_aceleracion = 2200.0  # Aceleración al aterrizar.
@export var fall_limit: float = 700.0  # Límite de caída antes de reiniciar.
@export var min_zoom_amount = 0.9  # Zoom mínimo de la cámara.
@export var max_zoom_amount = 1.5  # Zoom máximo de la cámara.

var target_tilt = 0.5  # Inclinación del sprite.
var finish_x = -1  # Posición X de la meta (inicialmente no definida).
@onready var sprite_2d: Sprite2D = $Sprite2D  # Referencia al sprite.
@onready var camera_2d: Camera2D = $Camera2D  # Referencia a la cámara.
@onready var ray_cast_2d: RayCast2D = $RayCast2D  # Referencia al RayCast2D.

# Textura para el estado "muerto"
@export var dead_texture: Texture2D

func _ready() -> void:
	# Configura el zoom inicial de la cámara.
	camera_2d.zoom = Vector2(max_zoom_amount, max_zoom_amount)

func _physics_process(delta: float) -> void:
	check_for_finish_line()  # Verifica si el jugador llegó a la meta.

	# Si el jugador cae más allá del límite, reinicia la escena.
	if position.y > fall_limit:
		print("Jugador cayó al vacío. Reiniciando nivel...")
		die()

	# Movimiento en el suelo.
	if is_on_floor():
		target_tilt = 0.0  # Restablece la inclinación.
		if velocity.x <= max_speed:
			velocity.x = move_toward(velocity.x, max_speed, aceleracion * delta)
		else:
			velocity.x = move_toward(velocity.x, max_speed, friccion * delta)

		# Salto al presionar el espacio.
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force
	else:
		# Movimiento en el aire.
		target_tilt = clamp(velocity.y / 4, -30, 30)  # Calcula la inclinación basada en la velocidad vertical.
		velocity.x = move_toward(velocity.x, 0, air_friccion * delta)

		# Reducción del salto al soltar el espacio.
		if Input.is_action_just_released("ui_accept"):
			velocity.y = unjump_force
		if velocity.y > 0:
			velocity.y += down_gravity * delta
		else:
			velocity.y += up_gravity * delta

	# Aplica movimiento y efectos visuales.
	var velocidad_previa = velocity
	move_and_slide()

	# Efecto de aterrizaje.
	if velocity.y == 0 and velocidad_previa.y > 5:
		sprite_2d.scale = Vector2(1.5, 0.8)
		velocity.x += landing_aceleracion * delta

	# Animación de inclinación y escala del sprite.
	sprite_2d.rotation = lerp_angle(sprite_2d.rotation, deg_to_rad(target_tilt), 0.2)
	sprite_2d.scale = sprite_2d.scale.lerp(Vector2.ONE, 0.05)

	# Ajuste dinámico de la cámara.
	var y_offset_target: float = clamp(ray_cast_2d.get_collision_point().y - global_position.y, -16, 128)
	camera_2d.offset.y = lerp(camera_2d.offset.y, y_offset_target, 0.02)

	var x_offset_target: float = clamp(velocity.x, -125, 128)
	camera_2d.offset.x = lerp(camera_2d.offset.x, x_offset_target, 0.02)

	var zoom_target_amount = clamp(max_zoom_amount - (velocity.x / 150), min_zoom_amount, max_zoom_amount)
	var zoom_target = Vector2(zoom_target_amount, zoom_target_amount)
	camera_2d.zoom = camera_2d.zoom.lerp(zoom_target, 0.02)

# Verifica si el jugador cruzó la línea de meta.
func check_for_finish_line() -> void:
	if global_position.x > finish_x and finish_x != -1:
		set_deferred("process_mode", PROCESS_MODE_DISABLED)  # Desactiva el procesamiento.
		process_mode = Node.PROCESS_MODE_DISABLED


# Función para manejar la muerte del jugador
func die():
	# Cambiar el sprite a la textura "muerta"
	if dead_texture:
		sprite_2d.texture = dead_texture
	
	# Desactivar el movimiento del jugador
	velocity = Vector2.ZERO
	set_physics_process(false)  # Detener la ejecución de _physics_process
	
	# Esperar un breve tiempo antes de reiniciar el nivel
	await get_tree().create_timer(1.0).timeout  # Espera 1 segundo
	get_tree().reload_current_scene()  # Reinicia el nivel
