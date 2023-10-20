hit_id = sprite_index

snd_play_hit_big(sndExplosionXL, 0.1)
snd_play(sndNothingDeath2)

sprite_index = spr_dead

repeat 30 {
    with instance_create(x + random(128) - 96, y + orandom(50), GreenExplosion)
    hit_id = other.hit_id
}

repeat 20 {
    instance_create(x + orandom(120), y + orandom(120), GroundFlame)
}

repeat 20 {
    with instance_create(x, y, BigRad)
    motion_add(200 + random(140), random(5) + 5)
}

if !instance_exists(BigGenerator) && !instance_exists(BigGeneratorInactive) alarm[1] = 60
else {
    instance_create(x, y + 8, SitDown)
    save_set_value("cgot", "12", 1)
}