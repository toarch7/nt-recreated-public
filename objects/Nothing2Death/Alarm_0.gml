snd_play(sndNothingDeath2)
repeat(30) {
    with(instance_create(((x + random(128)) - 64), ((y + random(100)) - 50), GreenExplosion))
    hit_id = other.hit_id
}
snd_play_hit_big(sndExplosionL, 0.1)
with(InvisiWall)
instance_destroy()
repeat(10) {
    with(instance_create(x, y, BigRad))
    motion_add((200 + random(140)), (random(5) + 5))
}
img = 0
repeat(5) {
    with(instance_create(x, y, Nothing2Corpse)) {
        size = 1
        motion_add(random_angle, (10 + random(6)))
        sprite_index = sprNothing2Part
        image_index = other.img
        image_xscale = choose(1, - 1)
        if (speed > 16) speed = 16
    }
    img += 1
}
dir = instance_nearest((x - 16), (y - 16), Floor)
with(instance_create((dir.x + 16), (dir.y + 16), BigPortal))
type = 1
instance_destroy()
snd_play_hit_big(sndNothing2Dead, 0.2)