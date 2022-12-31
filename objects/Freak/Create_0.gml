raddrop = 1
max_hp = 7
meleedamage = 3
size = 1

spr_idle = sprFreak1Idle
spr_walk = sprFreak1Walk
spr_hurt = sprFreak1Hurt
spr_dead = sprFreak1Dead

event_inherited()


snd_hurt = sndFreakHurt
snd_dead = sndFreakDead
snd_mele = sndFreakMelee

//behavior
alarm[1] = 20 + random(10)

walk = 0