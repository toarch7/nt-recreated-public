event_inherited()


repeat(40)
with instance_create(x, y, ToxicGas)
hit_id = other.spr_idle

snd_play(sndToxicBarrelGas)

dir = random_angle
repeat(20) {
    dir += 360 / 20
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.dir, 4)
        image_angle = direction
        team = other.team
        creator = other.id
    }
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, 8)
        image_angle = direction
    }
}

BackCont.shake += 20

repeat(5) {
    with instance_create(x, y, ExploderExplo)
    motion_add(random_angle, random(2) + 2)
}

snd_play(sndFrogExplode)

instance_create(x, y, PortalClear)