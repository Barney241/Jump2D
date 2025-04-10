extends Control



func _on_CheckBox_pressed():
	 OS.window_fullscreen = !OS.window_fullscreen


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
