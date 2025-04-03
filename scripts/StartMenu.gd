# StartMenu.gd

extends Control



func _on_StartGameButton_pressed():
	if get_node("/root/SavingSystem").DisplayValue != null:
		get_tree().change_scene("res://worlds/world_00.tscn")
	else:
		get_node("/root/SavingSystem").load_game("Values", "ValueOne")
	

func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_OptionButton_pressed():
	get_tree().change_scene("res://scenes/Options.tscn")

func _on_NewGame_pressed():
	get_tree().change_scene("res://worlds/world_00.tscn")
