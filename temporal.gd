extends Node

func _ready():
	var folder = "res://niveles/"
	var files = DirAccess.get_files_at(folder)
	
	print("Archivos en '", folder, "':")
	if files.size() == 0:
		print("⚠️ Carpeta vacía")
	else:
		for file in files:
			print(" - ", file)
