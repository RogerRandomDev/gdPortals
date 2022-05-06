extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player=self


func _process(delta):
	if Input.is_key_pressed(KEY_D):
		transform.origin.x+=1*delta
	if Input.is_key_pressed(KEY_A):
		transform.origin.x-=1*delta
	if Input.is_key_pressed(KEY_S):
		transform.origin.z+=1*delta
	if Input.is_key_pressed(KEY_W):
		transform.origin.z-=1*delta
