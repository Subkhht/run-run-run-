extends CenterContainer

const level_folder_path = "res://niveles/"

@onready var v_box_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer

# Al iniciar, carga los niveles y enfoca el primer botón si existe.
func _ready() -> void:
	fill_levels()  # Carga dinámicamente los niveles en el menú.
	if v_box_container.get_child_count() > 0:  # Si hay botones...
		v_box_container.get_child(0).grab_focus()  # ...enfoca el primero.

# Llena el VBoxContainer con botones para cada nivel encontrado en la carpeta.
func fill_levels() -> void:
	var level_paths = DirAccess.get_files_at(level_folder_path)  # Obtiene los archivos de la carpeta de niveles.
	for level_path in level_paths:  # Itera sobre cada archivo.
		var button = Button.new() 
		button.text = level_path.replace(".tscn", "").to_upper().replace("_", " ")  # Formatea el nombre del nivel.
		v_box_container.add_child(button)  # Añade el botón al contenedor.
		
		# Conecta el botón para cargar el nivel correspondiente cuando se presiona.
		button.pressed.connect(func(): get_tree().change_scene_to_file(level_folder_path + level_path))

# Cambia a la escena del menú principal cuando se presiona el botón "Atrás".
func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal.tscn")  # Vuelve al menú principal.
