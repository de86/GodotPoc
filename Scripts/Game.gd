extends Node

onready var WorldGenerator = $WorldGenerator
onready var WorldRenderer = $WorldRenderer


func _ready():
    randomize()
    var world = WorldGenerator.generate_world()    
    WorldRenderer.render_world(world)
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
