extends KinematicBody



const MOVE_SPEED = 100
const MOUSE_SENSITIVITY = 0.2
const MAX_Y_CAMERA_ANGLE = 180

const SPRINT = "camera_sprint"
const TOGGLE_MOUSE_CAPTURE = "camera_toggle_mouse_capture"

onready var camera = $Camera
onready var viewport = get_viewport()

var velocity = Vector3()
var camera_y_angle = 0
var is_mouse_movement_captured = false

var camera_movement_inputs = [
    INPUTS.MOVEMENT.FORWARD,
    INPUTS.MOVEMENT.BACK,
    INPUTS.MOVEMENT.UP,
    INPUTS.MOVEMENT.DOWN,
    INPUTS.MOVEMENT.STRAFE_LEFT,
    INPUTS.MOVEMENT.STRAFE_RIGHT
]



func _ready():
    _capture_mouse_movement()
    
    
    
func _physics_process(delta):
    if _get_is_movement_input_pressed():
        _move(delta)



func _input(event):
    if event is InputEventKey and event.is_action(TOGGLE_MOUSE_CAPTURE) and !event.pressed:
        _set_mouse_capture(!is_mouse_movement_captured)
    _aim(event)
    
    
    
func _capture_mouse_movement():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    is_mouse_movement_captured = true
        
 

func _release_mouse_movement():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    is_mouse_movement_captured = false

       
        
func _get_is_movement_input_pressed():
    var is_movement_input_pressed = false
    
    for i in range(camera_movement_inputs.size()):
        if Input.is_action_pressed(camera_movement_inputs[i]):
            is_movement_input_pressed = true
    
    return is_movement_input_pressed



func _move(delta):
    var move_speed = MOVE_SPEED
    var direction = Vector3()
    var transform_basis = camera.get_camera_transform().basis
    
    if Input.is_action_pressed(INPUTS.MOVEMENT.SPRINT):
        move_speed *= 2

    if Input.is_action_pressed(INPUTS.MOVEMENT.FORWARD) and not Input.is_action_pressed(INPUTS.MOVEMENT.BACK):
        direction += -transform_basis.z
    
    if Input.is_action_pressed(INPUTS.MOVEMENT.BACK) and not Input.is_action_pressed(INPUTS.MOVEMENT.FORWARD):
        direction += transform_basis.z
        
    if Input.is_action_pressed(INPUTS.MOVEMENT.UP) and not Input.is_action_pressed(INPUTS.MOVEMENT.DOWN):
        direction += transform_basis.y

    if Input.is_action_pressed(INPUTS.MOVEMENT.DOWN) and not Input.is_action_pressed(INPUTS.MOVEMENT.UP):
        direction += -transform_basis.y

    if Input.is_action_pressed(INPUTS.MOVEMENT.STRAFE_LEFT) and not Input.is_action_pressed(INPUTS.MOVEMENT.STRAFE_RIGHT):
        direction += -transform_basis.x

    if Input.is_action_pressed(INPUTS.MOVEMENT.STRAFE_RIGHT) and not Input.is_action_pressed(INPUTS.MOVEMENT.STRAFE_LEFT):
        direction += transform_basis.x

    velocity = direction.normalized() * move_speed * delta
    move_and_slide(velocity, Vector3.UP)
    
    
    
func _set_mouse_capture(should_capture):
        if should_capture:
            _capture_mouse_movement()
        else:
            _release_mouse_movement()
    
    
    
func _aim(event):
    if is_mouse_movement_captured and event is InputEventMouseMotion:
        rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
        
        var camera_y_rotation_change = -event.relative.y * MOUSE_SENSITIVITY
        if camera_y_angle + camera_y_rotation_change < 90 and camera_y_angle + camera_y_rotation_change > -90:
            camera.rotate_x(deg2rad(camera_y_rotation_change))
            camera_y_angle += camera_y_rotation_change



func _on_Game_pause_menu_toggled(is_paused):
    _set_mouse_capture(!is_paused)
