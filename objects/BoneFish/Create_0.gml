raddrop = 2
max_hp = 8
meleedamage = 2
size = 1

spr_idle = sprBoneFish1Idle
spr_walk = sprBoneFish1Walk
spr_hurt = sprBoneFish1Hurt
spr_dead = sprBoneFish1Dead

event_inherited()

snd_hurt = sndOasisHurt
snd_dead = sndOasisDeath
snd_mele = sndOasisMelee
hitid = HitId.BoneFish
//behavior
walk = 0
alarm[1] = 30 + random(90)