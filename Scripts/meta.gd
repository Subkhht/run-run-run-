extends TextureRect

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player is Player)
	player.finish_x = global_position.x
