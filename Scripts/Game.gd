extends Node



signal pause_menu_toggled(is_paused)

onready var world = $World
onready var pause_menu = $PauseMenu



func _input(event):
    if event is InputEventKey:
        if event.is_action_pressed(INPUTS.UI.TOGGLE_MENU):
            _toggle_menu()
            
            
            
func _toggle_menu():
    var scene_tree = get_tree()
    scene_tree.paused = !scene_tree.paused
    pause_menu.toggle(scene_tree.paused)
    emit_signal("pause_menu_toggled", scene_tree.paused)