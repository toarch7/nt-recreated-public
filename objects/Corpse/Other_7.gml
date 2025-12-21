image_index = image_number - 1
image_speed = 0

if (forceportal || scr_check_enemies()) exit

with (Corpse) alarm[0] = -1

alarm[0] = 30
	
if !place_meeting(x, y, Floor) {
	with instance_nearest(x, y, Floor) {
		other.x = bbox_center_x
		other.y = bbox_center_y
	}
	xprevious = x
	yprevious = y
}