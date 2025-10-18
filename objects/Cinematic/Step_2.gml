if lockstep_stop
	exit

if alarm[0] >= 50 {
    view_xview = x - view_width / 2
    view_yview = y - view_height / 2

    camera_set_view_pos(view_camera, view_xview, view_yview)

    instance_activate_object(TopSmall)
}