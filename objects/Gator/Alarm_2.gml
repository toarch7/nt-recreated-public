if !instance_exists(target) exit

snd_play(sndShotgun)
gunangle = target_direction
repeat(6) {
    with instance_create(x, y, EnemyBullet3) {
        motion_add(other.gunangle + (random(50) - 25), 10 + random(4))
        creator = other.id
        hit_id = other.spr_idle
        image_angle = direction
        creator = other.id
        team = other.team
    }
}
BackCont.shake += 1
wkick = 8

alarm[1] = 20 + random(5)