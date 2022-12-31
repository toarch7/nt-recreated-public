raddrop = 10
max_hp = 5
meleedamage = 2
size = 1

spr_idle = sprExploFreakIdle
spr_walk = sprExploFreakWalk
spr_hurt = sprExploFreakHurt
spr_dead = sprExploFreakDead

event_inherited()


snd_hurt = sndExploFreakHurt
snd_dead = sndExploFreakDead
snd_mele = sndExploFreakKillself

//behavior
alarm[1] = 20 + random(10)

walk = 0