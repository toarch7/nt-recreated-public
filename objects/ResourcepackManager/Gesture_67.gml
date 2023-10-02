if global.desktop
	exit

var mx = device_mouse_x_to_gui(event_data[? "touch"])

if mx < view_width - 24 && !dragging && !show_details {
	vspeed = -event_data[? "diffY"]
	scroll = 10
}