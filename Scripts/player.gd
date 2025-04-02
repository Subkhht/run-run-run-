extends CharacterBody2D

@export var up_gravity = 250
@export var down_gravity = 300
@export var jump_force = 190
@export var unjump_force = 20
@export var aceleracion = 150
@export var max_speed = 300
@export var friccion = 210
@export var air_friccion = 50
@export var landing_aceleracion = 2200.0

var target_tilt = 0.0
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:

	
	if is_on_floor():
		target_tilt = 0.0
		if velocity.x <= max_speed:
			velocity.x = move_toward(velocity.x, max_speed, aceleracion * delta)
		else:
			velocity.x = move_toward(velocity.x, max_speed, friccion * delta)
		
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force
	else:
		target_tilt = clamp(velocity.y / 4, -30, 30)
		
		velocity.x = move_toward(velocity.x, 0, air_friccion * delta)

		if Input.is_action_just_released("ui_accept"):
			velocity.y = unjump_force
		if velocity.y > 0:
			velocity.y += down_gravity * delta
		else:
			velocity.y += up_gravity * delta
	
	var velocidad_previa = velocity
	move_and_slide()
	
	if velocity.y == 0 and velocidad_previa.y > 5:
		sprite_2d.scale = Vector2(1.5, 0.8)
		velocity.x += landing_aceleracion * delta
	
	sprite_2d.rotation = lerp_angle(sprite_2d.rotation, deg_to_rad(target_tilt), 0.2)
	sprite_2d.scale = sprite_2d.scale.lerp(Vector2.ONE, 0.05)
