event_inherited()

max_hp = INT_MAX
hp = max_hp
meleedamage = 0
size = 8

spr_idle = sprNothingOn
spr_hurt = sprNothingOn
spr_dead = sprNothingDeath

drawimg = 0

image_speed = 0.4
alarm[0] = 200
alarm[4] = 170

scr_screenshake(5)

deadanim = 0
team = team_enemy
hitid = HitId.Throne

snd_hurt = sndHitRock

instance_create(x, y, NothingPipes)