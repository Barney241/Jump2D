extends Control

#var player = load("res://scripts/Player.gd").new()
var player = load("res://scripts/WorldComplete.gd")


func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_Nastaven_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")
	
	


func _on_Konec_pressed():
	
	get_node("SaveSystem").DisplayValue = Global.current_scene
	get_node("SaveSystem").save_game("Values", "ValueOne")
	get_tree().quit()
#	player.save_game()
#	get_tree().quit()





func _on_CheckBox_pressed():
	 OS.window_fullscreen = !OS.window_fullscreen


func _on_CheckBox2_pressed():
	OS.window_fullscreen = !OS.window_borderless


#var player = preload("res://scripts/SavingSystem.gd").new()







	





