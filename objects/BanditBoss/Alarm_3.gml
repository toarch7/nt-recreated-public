//CHARGING FUN

walk = 0

spr_idle = sprBanditBossTell
spr_walk = sprBanditBossDash
spr_hurt = sprBanditBossHurt
spr_dead = sprBanditBossDead
spr_fire = sprBanditBossStop

if gunangle > 90 and gunangle < 270 right = -1
else right = 1

snd_play(sndBigBanditMeleeStart)

alarm[4] = 15