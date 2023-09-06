if lockstep_stop
	exit

image_angle += spin
if (random(6) < 1) {
    with(instance_create(((x + random(10)) - 5), ((y + random(10)) - 5), MeatExplosion))
    hit_id = other.hit_id
}