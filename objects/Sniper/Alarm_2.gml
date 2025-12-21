snd_play(sndSniperFire)
wkick = 7
with instance_create(x, y, EnemyBullet4) {
    motion_add(other.gunangle + 4, 16)
    team = other.team
    hitid = other.hitid
    creator = other.id
    image_angle = direction
}
with instance_create(x, y, EnemyBullet4) {
    motion_add(other.gunangle - 4, 16)
    creator = other.id
    hitid = other.hitid
    team = other.team
    image_angle = direction
}
with instance_create(x, y, EnemyBullet4) {
    motion_add(other.gunangle, 16)
    team = other.team
    hitid = other.hitid
    creator = other.id
    image_angle = direction
}
if instance_exists(target) gunangle = mcr_target_direction
alarm[1] = 40 + random(5)
gonnafire = 0