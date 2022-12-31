snd_play(sndNothingStart)
raddrop = 500
max_hp = 1500

with BigGeneratorInactive {
    with instance_create(x, y, BigGenerator) {
        image_xscale = other.image_xscale
    }

    instance_destroy(id, 0)
}

max_hp *= 1 + (GameCont.loops / 3)
meleedamage = 10
size = 8

spr_idle = sprNothingMiddle
spr_walk = sprNothingMiddle
spr_hurt = sprNothingHurt
spr_dead = sprNothingMiddle

event_inherited()
hit_id = sprKilledByThrone

hp = max_hp

snd_hurt = sndNothingHurtHigh
snd_dead = sndThroneDeath

walk = 0
footstep = 0
walkdir = 0
ammo = 0
mode = 0
introwalk = 0
targetx = x
targety = y + 1000
alarm[1] = 30
scrTarget()
friction = 1.7
wave = 0
dmg = 0
flame = sprThroneFlameIdle
flanim = 0
sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0