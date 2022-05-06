extends Node3D

var updated=false
func _ready():
	$MeshInstance3D.texture=$SubViewport.get_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SubViewport/Node3D.global_transform.origin=global_transform.origin
	var gap=(Global.player.global_transform.origin-global_transform.origin)
	var rotation_difference=(Global.player.rotation-rotation)
	var distance=gap.length()
	$SubViewport/Node3D/Camera3D.near=distance+0.01
	$SubViewport/Node3D/Camera3D.transform.origin=-gap
	$SubViewport/Node3D/Camera3D.rotation=-rotation_difference+Vector3(0,PI,0)
