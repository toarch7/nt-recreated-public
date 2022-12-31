if alarm[0] >= 5 {
    with instance_create(x + random_spread(128), y + random_spread(128), choose(Explosion, Explosion, GreenExplosion)) {
        hit_id = other.sprite_index
    }
    snd_play_hit_big(sndExplosionS, 0.2)
}

with projectile {
    if team == other.team {
        instance_destroy()
    }
}

with Guardian {
    instance_destroy()
}