raddrop = 10
max_hp = 22
meleedamage = 1
size = 1

spr_idle = sprBigMaggotIdle
spr_walk = sprBigMaggotIdle
spr_hurt = sprBigMaggotHurt
spr_dead = sprBigMaggotDead

event_inherited()


snd_hurt = sndBigMaggotHit
snd_dead = sndBigMaggotDie
snd_mele = sndBigMaggotBite

//behavior
alarm[1] = 45 + random(10)
rage = 0

spr_shadow = shd32