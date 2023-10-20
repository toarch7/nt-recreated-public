repeat 32 {
    with instance_create(x + orandom(32), y + orandom(32), SmallExplosion) hit_id = other.sprite_index
    with instance_create(x + orandom(48), y + orandom(48), Explosion) hit_id = other.sprite_index
}

repeat 20 instance_create(x + orandom(80), y + orandom(80), GroundFlame)

snd_play_hit_big(sndExplosionXL, 0.1)
instance_destroy()
var img = 0

repeat 6 {
    with instance_create(x, y, ScrapBossCorpse) {
        size = other.size - 1
        motion_add(random_angle, (10 + random(6)))
        sprite_index = sprScrapBossDead
        image_xscale = choose(1, - 1)
        image_index = img
    }

    img += 1
}