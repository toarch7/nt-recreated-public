snd_play(sndExplosionL)

ang = random_angle
instance_create(x + lengthdir_x(16, ang), y + lengthdir_y(16, ang), GreenExplosion)
instance_create(x + lengthdir_x(16, ang + 120), y + lengthdir_y(16, ang + 120), GreenExplosion)
instance_create(x + lengthdir_x(16, ang + 240), y + lengthdir_y(16, ang + 240), GreenExplosion)

repeat 8 {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random_angle, random(other.raddrop / 2) + 3)

        repeat(speed)
        speed *= 0.9
    }
}