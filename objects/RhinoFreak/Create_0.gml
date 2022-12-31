raddrop = 20
max_hp = 80
meleedamage = 5
size = 2

spr_idle = sprRhinoFreakIdle
spr_walk = sprRhinoFreakWalk
spr_hurt = sprRhinoFreakHurt
spr_dead = sprRhinoFreakDead

event_inherited()



snd_hurt = sndRhinoFreakHurt
snd_dead = sndRhinoFreakDead
snd_mele = sndRhinoFreakMelee


//behavior
alarm[1] = 20 + random(10)
spr_shadow_y = 4
spr_shadow_x = -2
walk = 0