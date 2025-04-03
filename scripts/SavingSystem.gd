extends Node

var DisplayValue 
var save_path = "res://saves/save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)
var hiest_score 





var current_scene = null

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)
	
func save_game(section, key):
	config.set_value(section, key, DisplayValue)
	config.save(save_path)
	
func save_score(section, key):
	config.set_value(section, key, hiest_score)
	config.save(save_path)
	
func load_game(section, key):
	DisplayValue = config.get_value(section, key, DisplayValue)
	get_tree().change_scene(DisplayValue)
	get_tree().get_current_scene().get_name()
	
func load_score(section, key):
	hiest_score = config.get_value(section, key, DisplayValue)
	Global.hiest_score = hiest_score


#func save():
#	var save_dict = {
#		"filename" : get_filename(),
#		"parent" : get_parent().get_path(),
#		"world" : player.current_world,
#		"name" :"s",
#		"path" :"s"
#		}
#	return save_dict
#
#func save_game():
#    var save_game = File.new()
#    save_game.open("res://saves/save-file.json", File.WRITE)
#    var save_nodes = get_tree().get_nodes_in_group("save")
#    for i in save_nodes:
#        var node_data = i.call("save");
#        save_game.store_line(to_json(node_data))
#    save_game.close()
## Note: This can be called from anywhere inside the tree. This function
## is path independent.
#func load_game():
#    var save_game = File.new()
#    if not save_game.file_exists("res://saves/save-file.json"):
#        return # Error! We don't have a save to load.
#
#    # We need to revert the game state so we're not cloning objects
#    # during loading. This will vary wildly depending on the needs of a
#    # project, so take care with this step.
#    # For our example, we will accomplish this by deleting saveable objects.
#    var save_nodes = get_tree().get_nodes_in_group("save")
#    for i in save_nodes:
#        i.queue_free()
#
#    # Load the file line by line and process that dictionary to restore
#    # the object it represents.
#    save_game.open("res://saves/save-file.json", File.READ)
#    while not save_game.eof_reached():
#        var current_line = parse_json(save_game.get_line())
#        # Firstly, we need to create the object and add it to the tree and set its position.
#        var new_object = load(current_line["filename"]).instance()
#        get_node(current_line["parent"]).add_child(new_object)
#
#        # Now we set the remaining variables.
#        for i in current_line.keys():
#            if i == "filename" or i == "parent" or i== "word":
#                continue
#            new_object.set(i, current_line[i])
#    save_game.close()






