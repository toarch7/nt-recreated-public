alarm[0] = 10

wepangle *= -1
if instance_exists(target) gunangle = mcr_target_direction

motion_add(gunangle, 6)
snd_play_hit_big(sndEliteInspectorFire, 0.2)

with instance_create(x, y, EnemySlash) {
    sprite_index = sprPopoSlash
    hitid = other.hitid
    image_angle = other.gunangle
    motion_add(other.gunangle, 2)
    team = other.team
    damage = 8
}

alarm[1] = 15 + random(5)