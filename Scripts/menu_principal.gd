extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_seleccion.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal_opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
