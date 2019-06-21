extends Node


var WORLD_SIZE = 10
var terrain = []
var actors = []
var scenery_items = ['@', '#', '=', '0']



func generate_world():
    for y in range(WORLD_SIZE):
        terrain.push_back(generate_random_terrain_row())

    create_paths()
    
    print_world()
    
    return terrain



func get_random_scenery_item():
    var random_index = randi() % scenery_items.size()
    return scenery_items[random_index]
    


func generate_random_terrain_row():
    var row = []
    
    for x in range(WORLD_SIZE):
        row.push_back(get_random_scenery_item())
        
    return row



func create_paths():
    create_horizontal_path()
    create_horizontal_path()
    create_vertical_path()
    create_vertical_path()



func create_horizontal_path():
    var horizontal_path_y = randi() % terrain.size()
    var row = terrain[horizontal_path_y]
    for x in range(row.size()):
        row[x] = '0'


    
func create_vertical_path():
    var vertical_path_x = randi() % terrain.size()
    for y in range(terrain.size()):
        terrain[y][vertical_path_x] = '0'
    


func print_world():
    for y in range(terrain.size()):
        print(terrain[y])
        
            