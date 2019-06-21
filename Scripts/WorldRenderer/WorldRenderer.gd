extends Node


export (PackedScene) var TileBase

onready var TerrainNodeMap = $TerrainNodeMap



func render_world(world_map):
    # Use x and z as axis as we can imagine our 2D array of tiles lying flat on the floor and
    # not upright on the x and y axis
    for z in range(world_map.size()):
        var map_row = world_map[z]
        for x in range(map_row.size()):
            spawn_in_world(map_row[x], Vector3(x, 0, z))



func spawn_in_world(terrain_type, global_pos):
    var tile_base_instance = TileBase.instance()
    add_child(tile_base_instance)
    tile_base_instance.global_translate(global_pos)
    if terrain_type != '0':
        var terrain_node_instance = get_terrain_node(terrain_type).instance()
        add_child(terrain_node_instance)
        var tile_decor_anchor_pos = tile_base_instance.find_node('DecorAnchor').get_global_transform().origin
        terrain_node_instance.global_translate(tile_decor_anchor_pos)
        


func get_terrain_node(terrain_type):
    return TerrainNodeMap.get_terrain_node(terrain_type)
    