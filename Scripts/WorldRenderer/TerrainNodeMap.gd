extends Node


export (PackedScene) var Cube
export (PackedScene) var Cylinder
export (PackedScene) var Prism

var CUBE = 'CUBE'
var CYLINDER = 'CYLINDER'
var PRISM = 'PRISM'
var EMPTY = 'EMPTY'

onready var terrain_types = {
    '@': CUBE,
    '#': CYLINDER,
    '=': PRISM,
    '0': EMPTY
}

onready var terrain_nodes = {
    CUBE: Cube,
    CYLINDER: Cylinder,
    PRISM: Prism
}


func get_terrain_node(terrain_type):
    return terrain_nodes[terrain_types[terrain_type]]
    