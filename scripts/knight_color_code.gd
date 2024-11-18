extends AnimatedSprite2D

func _on_feather_color_picker_color_changed(color):
	material.set_shader_parameter("feather_color", color)


func _on_cape_color_picker_color_changed(color):
	material.set_shader_parameter("cape_color", color)
