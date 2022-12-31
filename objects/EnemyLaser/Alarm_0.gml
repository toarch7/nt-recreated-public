var dir;
dir = 0
do {
    x += lengthdir_x(2, image_angle) y += lengthdir_y(2, image_angle) dir += 1
}
until (place_meeting(x, y, hitme) and dir > 16) or place_meeting(x, y, Wall) or dir > 160

alarm[0] = 2

image_xscale = point_distance(x, y, xstart, ystart) / 2
instance_create(x, y, Smoke)