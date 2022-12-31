max_hp = 1
size = 1

spr_idle = sprTV
spr_hurt = sprTV
spr_dead = sprTV


event_inherited()


snd_hurt = sndHitMetal

anim = 0

tv = choose(1, 2, 3)

if tv = 1 myscreen = choose(sprTV1A, sprTV1B, sprTV1C)

if tv = 2 myscreen = choose(sprTV2A, sprTV2B, sprTV2C)

if tv = 3 myscreen = choose(sprTV3A, sprTV3B, sprTV3C)

if !irandom(20) {
    tv = 4
    myscreen = sprTV4A
}

alarm[0] = 30 + random(90)

stuck = 0