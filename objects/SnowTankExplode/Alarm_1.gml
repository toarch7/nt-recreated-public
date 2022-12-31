snd_play(sndExplosionL)

repeat(3) {
    with instance_create(x + random(8) - 4, y + random(8) - 4, Explosion) {
        hit_id = other.sprite_index
    }
}

with instance_create(x, y, Corpse) {
    size = 2
    sprite_index = sprSnowTankDead
    if other.sprite_index == sprGoldTankExplode {
        sprite_index = sprGoldTankDead
    }
}

instance_destroy()

repeat 5 {
    with instance_create(x, y, GroundFlame)
    move_contact_solid(random(360), 8 + random(16))
}