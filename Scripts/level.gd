extends Node2D

# _process(delta) se ejecuta en cada fotograma. Aquí detectamos la entrada "ui_cancel".
func _process(delta: float) -> void:
	# Si se presiona "ui_cancel", recargamos la escena actual de forma segura.
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene.call_deferred()       
