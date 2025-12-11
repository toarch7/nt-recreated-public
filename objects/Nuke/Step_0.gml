image_angle = direction

if (active) exit

if (current_frame_active) with (instance_create(x, y, Smoke)) {
	depth = other.depth + 1
}
	
if (instance_exists(creator)) motion_add(creator.gunangle, 0.5)

with (BackCont) shake = min(shake, 3)

motion_add(direction, 0.5)

if (speed > 5) speed = 5