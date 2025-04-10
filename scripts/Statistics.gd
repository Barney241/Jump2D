extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")

onready var level_list_container = $CenterContainer/VBoxContainer/levels # Assign a VBoxContainer node here

func _ready():
	display_completed_levels()

func display_completed_levels():
	# Clear previous entries if any
	for child in level_list_container.get_children():
		child.queue_free()

	# Get the list of completed level IDs from the SaveManager
	var completed_levels = get_node("/root/SavingSystem").get_completed_levels()

	if completed_levels.empty():
		var label = Label.new()
		label.text = "No levels completed yet!"
		level_list_container.add_child(label)
		return

	# Sort the levels if desired (e.g., alphabetically or by a defined order)
	completed_levels.sort()
	 # Simple alphabetical sort
	var completed_label = Label.new()
	completed_label.text = "Completed levels:"
	level_list_container.add_child(completed_label)
	
	# Create a label or custom scene instance for each completed level
	for level_id in completed_levels:
		var label = Label.new()
		# You might want to format the ID nicely for display
		var name = level_id
		if name == "world_00":
			name = "world_01"
		label.text = "	%s (High Score: %s)" % [name.capitalize(), get_node("/root/SavingSystem").get_lvl_highest_score(level_id)]
		level_list_container.add_child(label)
