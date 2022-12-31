scrDrop(40, 0)

instance_create(x, y, Explosion)
event_inherited()

snd_play(sndExplosion)

repeat 2 + irandom(3) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random(360), 4 + random(16))
    }
}