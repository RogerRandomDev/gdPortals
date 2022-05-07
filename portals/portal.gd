extends Node3D

var updated=false
@export_node_path(Node3D) var connectedPortal

var query=PhysicsShapeQueryParameters3D.new()
func _ready():
	query.shape=BoxShape3D.new()
	query.shape.extents=Vector3(1,1,0.01)
	$MeshInstance3D.material_override.set_shader_param("TEXTURE",get_node(connectedPortal).get_portal_texture())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var linked: Node = get_node(connectedPortal)
	var portal=self
	var trans: Transform3D = linked.global_transform.inverse() \
			* get_viewport().get_camera_3d().global_transform
	var up := Vector3(0, 1, 0)
	trans = trans.rotated(up, PI)
	portal.get_node("CameraHolder").transform = trans
	var cam_pos: Transform3D = portal.get_node("CameraHolder").global_transform
	portal.get_node("Viewport/Camera").transform = cam_pos
	query.transform=global_transform
	portal.get_node("Viewport").size = get_viewport().size
	var colliding:=get_world_3d().direct_space_state.intersect_shape(query)
	if colliding:check_colliding(colliding)

#returns portal viewport
func get_portal_texture():
	return $Viewport.get_texture()




#checks colliding object relative to self
func check_colliding(colliding):
	for collide in colliding:
		var object=collide.collider
		
		if point_inside_self(object.global_transform.origin):
			var moved=object
			if object.get_parent().name=="Camera3D":moved=object.get_parent()
			moved.global_transform.origin=get_node(connectedPortal).global_transform.origin
			var rotation_difference=get_node(connectedPortal).rotation-rotation
			moved.rotation+=rotation_difference+Vector3(0,PI,0)
			var rot=get_node(connectedPortal).rotation
			var n_rot=Vector3(sin(rot.y),sin(rot.x),cos(rot.y))
			moved.global_transform.origin+=n_rot*0.05


func point_inside_self(point):
	var p=PhysicsPointQueryParameters3D.new()
	p.position=point
	p.collision_mask=2
	if get_world_3d().direct_space_state.intersect_point(p):
		return true
	else:
		return false
	
	
	
