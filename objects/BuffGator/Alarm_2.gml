if !instance_exists(target) exit

snd_play(sndFlakCannon)
gunangle = target_direction
alarm[0] += 45
with instance_create(x, y, EnemyFlak) {
    motion_add(other.gunangle + (random(50) - 25), 8 + random(2))
    creator = other.id
    hit_id = other.spr_idle
    image_angle = direction
    creator = other.id
    team = other.team
}
BackCont.shake += 1
wkick = 8

alarm[1] = 20 + random(5)