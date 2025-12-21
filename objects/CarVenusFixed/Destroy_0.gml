repeat (5) instance_create(x + orandom(3), y + orandom(3), Explosion)

if (GameCont.area == area_crib) instance_create(x, y, CarVenusRespawn)

repeat (2 + irandom(3)) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random_angle, 4 + random(16))
    }
}

corpse = false

event_inherited()

snd_play(sndExplosionCar)
snd_stop(sndCarLoop)