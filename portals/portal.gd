extends Node3D

var updated=false
@export_node_path(Node3D) var connectedPortal
func _ready():
	$MeshInstance3D.material_override.set_shader_param("TEXTURE",get_node(connectedPortal).get_portal_texture())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var connectedPortalDat=get_node(connectedPortal).get_camera_info(rotation)
	#this moves the camera where it is needed
	var linked: Node = get_node(connectedPortal)
	var trans: Transform3D = linked.global_transform.inverse() \
			* get_viewport().get_camera_3d().global_transform
	var up := Vector3(0, 1, 0)
	trans = trans.rotated(up, PI)
	get_node(connectedPortal).get_node("SubViewport/Node3D/Camera3D").transform = trans
	var cam_pos: Transform3D = get_node(connectedPortal).get_node("SubViewport/Node3D/Camera3D").global_transform
	


#builds the information of where to move the connected portals camera
func get_camera_info(rotval):
	var gap=(Global.player.global_transform.origin-global_transform.origin)
	var rotation_difference=( -Global.player.rotation-rotation-rotval)
	return [gap,rotation_difference]
	


#returns portal viewport
func get_portal_texture():
	return $SubViewport.get_texture()


