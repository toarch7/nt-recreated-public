raddrop = 25
max_hp = 30
meleedamage = 5
size = 2
hit_id = sprPopoFreakIdle
spr_idle = sprPopoFreakIdle
spr_walk = sprPopoFreakWalk
spr_hurt = sprPopoFreakHurt
spr_dead = sprPopoFreakDead
event_inherited()
snd_hurt = sndFreakPopoHurt
snd_dead = sndFreakPopoDead
snd_mele = sndFreakMelee

alarm[1] = (20 + random(10))
walkdir = random(360)
walk = 0
ammo = 0
wkick = 0
gunangle = random(360)
snd_play_hit_big(sndFreakPopoEnter, 0.3)
instance_create(x, y, PortalClear)

spr_shadow = shd32
spr_shadow_y = 4

depth = -2