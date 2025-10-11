raddrop = 0
max_hp = 35
meleedamage = 0
size = 1

spr_idle = sprFrogEgg
spr_walk = sprFrogEgg
spr_hurt = sprFrogEggHurt
spr_dead = sprFrogEggDead

event_inherited()

snd_play_hit(choose(sndFrogEggSpawn1, sndFrogEggSpawn2, sndFrogEggSpawn3), 0.2)

snd_hurt = sndFrogEggHurt
snd_dead = sndFrogEggDead

friction = 1000
//behavior
walk = 0
alarm[1] = 120