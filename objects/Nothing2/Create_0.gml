BackCont.shake += 10
raddrop = 70
max_hp = (600 * ((KeyCont.players / 2) + 0.5))
max_hp *= (1 + (GameCont.loops / 3))
with(MusCont)
alarm[5] = 1
alarm[2] = 2
meleedamage = 10
size = 6
spr_idle = sprNothing2Idle
spr_walk = sprNothing2Idle
spr_hurt = sprNothing2Hurt
spr_dead = sprNothing2Death
with(Wall) {
    if (place_free((x - 16), y) && (place_free((x + 16), y) && (place_free(x, (y + 16)) && place_free(x, (y - 16))))) {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
}
with(Bones)
instance_destroy()
event_inherited()
hit_id = sprKilledByThrone2
walk = 0
right = 1
scrTarget()
side = choose(1, - 1)
shots = 0
walkdir = random_angle
aimdir = random_angle
direction = random_angle
alarm[0] = 1
alarm[1] = 90
with(MusCont)
alarm[2] = 1
snd_hurt = sndNothing2Hurt
snd_dead = sndNothing2Dead
instance_create(x, y, SpiralCont)
instance_create(x, y, NothingSpiral)
snd_play_hit_big(sndNothing2Appear, 0)
flip = choose(1, - 1)
attack = 1
sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0