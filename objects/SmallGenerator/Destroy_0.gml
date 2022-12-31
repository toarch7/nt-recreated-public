event_inherited()

with instance_create(x, y, GreenExplosion) {
    hit_id = other.spr_idle
    team = -1

    snd_play_hit(sndExplosion, 0.2)
    creator = noone
}

repeat 6 instance_create(x + random(64) - 32, y + random(64) - 32, GroundFlame)
repeat 5 instance_create(x, y, Rad)