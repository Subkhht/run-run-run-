extends Node2D

# _process(delta) se ejecuta en cada fotograma. Aquí detectamos la entrada "ui_cancel".
func _process(delta: float) -> void:
	# Si presionas el ESC sales al selector niveles
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menu_seleccion.tscn")
		 
	# Si se presiona la flecha hacia la izq, recargamos la escena actual de forma segura.
	if Input.is_action_just_pressed("ui_left"):
		get_tree().reload_current_scene.call_deferred()      
