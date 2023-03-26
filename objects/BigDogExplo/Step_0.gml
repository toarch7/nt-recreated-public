if random(8) < 1 {
    with instance_create(x + orandom(24), y + orandom(24), Explosion) {
        hit_id = other.sprite_index
    }

    snd_play(sndExplosion)
}

if random(4) < 1 {
    with instance_create(x + orandom(12), y + orandom(12), SmallExplosion) {
        hit_id = other.sprite_index
    }

    snd_play(sndExplosion)
}