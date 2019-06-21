extends KinematicBody

const MOVE_SPEED = 100
const MOUSE_SENSITIVITY = 0.2
const MAX_Y_CAMERA_ANGLE = 180

const FORWARD = "camera_forward"
const BACK = "camera_back"
const UP = "camera_up"
const DOWN = "camera_down"
const STRAFE_LEFT = "camera_strafe_left"
const STRAFE_RIGHT = "camera_strafe_right"
const SPRINT = "camera_sprint"

onready var camera = $Camera
onready var viewport = get_viewport()

var velocity = Vector3()
var camera_y_angle = 0

var camera_movement_inputs = [
    FORWARD,
    BACK,
    UP,
    DOWN,
    STRAFE_LEFT,
    STRAFE_RIGHT
]


func _physics_process(delta):
    if _get_is_camera_movement_input_pressed():
        _move(delta)



func _input(event):
    _aim(event)
        
        
        
func _get_is_camera_movement_input_pressed():
    var is_camera_movement_input_pressed = false
    
    for i in range(camera_movement_inputs.size()):
        if Input.is_action_pressed(camera_movement_inputs[i]):
            is_camera_movement_input_pressed = true
    
    return is_camera_movement_input_pressed



func _move(delta):
    var move_speed = MOVE_SPEED
    var direction = Vector3()
    var transform_basis = camera.get_camera_transform().basis
    
    if Input.is_action_pressed(SPRINT):
        move_speed *= 2

    if Input.is_action_pressed(FORWARD) and not Input.is_action_pressed(BACK):
        direction += -transform_basis[2]
    
    if Input.is_action_pressed(BACK) and not Input.is_action_pressed(FORWARD):
        direction += transform_basis[2]
        
    if Input.is_action_pressed(UP) and not Input.is_action_pressed(DOWN):
        direction += transform_basis[1]

    if Input.is_action_pressed(DOWN) and not Input.is_action_pressed(UP):
        direction += -transform_basis[1]

    if Input.is_action_pressed(STRAFE_LEFT) and not Input.is_action_pressed(STRAFE_RIGHT):
        direction += -transform_basis[0]

    if Input.is_action_pressed(STRAFE_RIGHT) and not Input.is_action_pressed(STRAFE_LEFT):
        direction += transform_basis[0]

    velocity = direction.normalized() * move_speed * delta
    move_and_slide(velocity, Vector3(0, 1, 0))
    
    
func _aim(event):
    if event is InputEventMouseMotion:
        rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
        
        var camera_y_rotation_change = -event.relative.y * MOUSE_SENSITIVITY
        if camera_y_angle + camera_y_rotation_change < 90 and camera_y_angle + camera_y_rotation_change > -90:
            camera.rotate_x(deg2rad(camera_y_rotation_change))
            camera_y_angle += camera_y_rotation_change
    