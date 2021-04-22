tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Camera FPS",
					"Camera",
					preload("camera_Fps_script.gd"), 
					preload("icon.png")
					)

func _exit_tree():
	remove_custom_type("Orbit")
