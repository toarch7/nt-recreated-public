if ammo > 0 {
    snd_play(sndEnemyFire)
    wkick = 5
    with instance_create(x, y, EnemyBullet1) {
        motion_add(other.gunangle + random(16) - 8, 4)
        image_angle = direction
        team = other.team
        creator = other.id
        hitid = other.hitid
    }
    ammo -= 1
    alarm[2] = 5
}