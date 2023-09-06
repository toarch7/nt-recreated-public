if lockstep_stop
	exit

if size >= other.size - 1 and speed > 2 and other.sprite_index != other.spr_hurt {
    with other {
        hp -= round(1 + other.speed / 5)
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, other.speed / 2)
    }
    sleep(2 * size * size)
    speed /= 2
}