if random(8) < 1 {
    with instance_create(x + random_spread(24), y + random_spread(24), Explosion) {
        hit_id = other.sprite_index
    }

    snd_play(sndExplosion)
}

if random(4) < 1 {
    with instance_create(x + random_spread(12), y + random_spread(12), SmallExplosion) {
        hit_id = other.sprite_index
    }

    snd_play(sndExplosion)
}