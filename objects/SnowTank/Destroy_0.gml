speed = 0
event_inherited()
scrDrop(50, 0)
scrDrop(50, 0)

BackCont.shake += 5

instance_create(x, y, SnowTankExplode)
for (i = 0; i < 360; i += 30) {
    with instance_create(x, y, Smoke) {
        motion_add(other.i, 5)
    }
}

snd_play_hit_big(snd_dead, 0.2)