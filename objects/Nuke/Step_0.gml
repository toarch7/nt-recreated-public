image_angle = direction

if (!active) exit

if (current_frame_active) with (instance_create(x, y, Smoke)) {
	x -= ldrx(6, other.image_angle)
	y -= ldry(6, other.image_angle)
	depth = other.depth + 1
}
	
if (index >= 0) motion_add(KeyCont.dir_fire[index], 0.5)

with (BackCont) shake = min(shake, 3)

motion_add(direction, 0.5)

if (speed > 5) speed = 5