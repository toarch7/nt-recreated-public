if lockstep_stop
	exit

if (BackCont.shake < 2) BackCont.shake = 2

x += (random(2) - 1)
y += (random(2) - 1)

repeat 2 {
    image_angle += (6 * speed)
    with(instance_create(x, y, Flame)) {
        motion_add(other.image_angle, (random(1) + 2))
        team = other.team
        hitid = other.hitid
    }
    with(instance_create(x, y, Flame)) {
        motion_add((other.image_angle + 180), (random(1) + 2))
        team = other.team
        hitid = other.hitid
    }
}
if (speed == 0) instance_destroy()