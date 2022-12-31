if ammo {
    with instance_create(x, y, EnemyBullet3) {
        motion_add(other.gunangle + random_range(-8, 8), 13 - random(2))
        image_angle = direction
        team = other.team
        creator = other.id
    }

    ammo--wkick = 4
    snd_play(sndPopgun)
    alarm[2] = 4
}