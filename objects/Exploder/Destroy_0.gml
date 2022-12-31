event_inherited()

dir = random(360)
repeat(8) {
    dir += 45
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.dir, 4)
        image_angle = direction
        creator = other.id
        team = other.team
        hit_id = other.spr_idle
    }
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, 8)
        image_angle = direction
    }
}

BackCont.shake += 10

repeat(3) {
    with instance_create(x, y, ExploderExplo)
    motion_add(random(360), random(2) + 2)
}

snd_play(sndFrogExplode)