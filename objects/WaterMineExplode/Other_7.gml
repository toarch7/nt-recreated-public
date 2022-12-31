instance_create(x + random(6) - 3, y + random(6) - 3, Explosion)
instance_create(x, y + 6, Scorchmark)
event_inherited()

ang = random(360)

repeat 10 {
    with instance_create(x, y, AllyBullet) {
        motion_add(other.ang, 4)
        image_angle = direction
        team = -1
    }

    ang += 360 / 10
}

snd_play(sndOasisExplosion)
instance_destroy()