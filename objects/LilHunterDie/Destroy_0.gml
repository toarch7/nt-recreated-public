snd_play(sndExplosionL)
snd_play(sndLilHunterDeath)
repeat(1 + GameCont.loops) {
    ang = random_angle
    with(instance_create((x + lengthdir_x(12, ang)), (y + lengthdir_y(12, ang)), Explosion))
    hit_id = other.sprite_index
    with(instance_create((x + lengthdir_x(12, (ang + 120))), (y + lengthdir_y(12, (ang + 180))), Explosion))
    hit_id = other.sprite_index
    with(instance_create((x + lengthdir_x(12, (ang + 240))), (y + lengthdir_y(12, (ang + 180))), Explosion))
    hit_id = other.sprite_index
}
with(instance_create(x, y, Corpse)) {
    size = 1
    mask_index = mskPlayer
    motion_add(other.direction, other.speed)
    sprite_index = sprLilHunterDead
    image_xscale = choose(1, - 1)
    if instance_exists(Player) {
        if (skill_get(20)) speed += 8
    }
    if (speed > 16) speed = 16
    if (size > 0) speed /= size
}