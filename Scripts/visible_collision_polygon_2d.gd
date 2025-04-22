class_name VisibleCollisionPolygon2D extends CollisionPolygon2D

@export var color: Color = Color.WHITE  # Color visible para el polígono.

# _ready() se llama cuando el nodo entra en el árbol de escena.
func _ready() -> void:
	var sprite = Polygon2D.new()  # Crea un nuevo nodo Polygon2D para visualizar el polígono.
	add_child(sprite)  # Añade el nodo Polygon2D como hijo de este nodo.
	sprite.polygon = polygon  # Asigna el mismo polígono que tiene CollisionPolygon2D.
	sprite.color = color  # Aplica el color definido en la variable 'color'.
