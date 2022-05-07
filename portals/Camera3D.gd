extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player=self


func _process(delta):
	var dir=Vector2.ZERO
	if Input.is_key_pressed(KEY_D):
		dir.x+=1*delta
	if Input.is_key_pressed(KEY_A):
		dir.x-=1*delta
	if Input.is_key_pressed(KEY_S):
		dir.y+=1*delta
	if Input.is_key_pressed(KEY_W):
		dir.y-=1*delta
	dir=dir.rotated(-rotation.y)
	transform.origin+=Vector3(dir.x,0,dir.y)

var in_game=true
var sensitivity=0.01;
var maxRotation=1.5708
func _input(event):
	#exits to menu
	if Input.is_action_just_pressed("esc"):
		in_game=!in_game
		if in_game:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion&&in_game:
		var rotBase=(Vector2(512,300)-get_viewport().get_mouse_position())*sensitivity
		#rotates parent around x, but looking up and down is relative to camera
		rotation.y+=rotBase.x
		rotation.x=clamp(rotation.x+rotBase.y,-maxRotation,maxRotation)
		get_viewport().warp_mouse(Vector2(512,300))
