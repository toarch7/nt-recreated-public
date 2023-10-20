image_speed = 0.4
visible = 1

with Corpse
if sprite_index == sprMutant4Dead or sprite_index == sprMutant4BDead {
    snd_play(sndExplosion)

    if skill_get(5) {
        snd_play(sndCorpseExploUpg)
    } else {
        snd_play(sndCorpseExplo)
    }

    with instance_create(x, y, BloodStreak) {
        motion_add(point_direction(other.x, other.y, x, y), 8)
        image_angle = direction
    }

    instance_create(x, y, MeltSplat)

    if skill_get(5) {
        ang = random_angle
        instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
        instance_create(x + lengthdir_x(24, ang + 120), y + lengthdir_y(24, ang + 120), MeatExplosion)
        instance_create(x + lengthdir_x(24, ang + 240), y + lengthdir_y(24, ang + 240), MeatExplosion)
    }

    instance_create(x, y, MeatExplosion)

    other.x = x
    other.y = y

    instance_destroy()
}