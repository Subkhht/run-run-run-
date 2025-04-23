class_name VisibleCollisionPolygon2D extends CollisionPolygon2D

@export var texture_path: String = "res://textures/wood-table-texture-free-photo.jpg"  # Ruta de la textura.

# _ready() se llama cuando el nodo entra en el árbol de escena.
func _ready() -> void:
	var sprite = Polygon2D.new()  # Crea un nuevo nodo Polygon2D para visualizar el polígono.
	add_child(sprite)  # Añade el nodo Polygon2D como hijo de este nodo.
	sprite.polygon = polygon  # Asigna el mismo polígono que tiene CollisionPolygon2D.
	
	# Carga la textura desde la ruta y la aplica al Polygon2D.
	var texture = load(texture_path)  # Carga la textura.
	if texture:
		sprite.texture = texture  # Aplica la textura al Polygon2D.
	else:
		print("Error: No se pudo cargar la textura desde ", texture_path)
