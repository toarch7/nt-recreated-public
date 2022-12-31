raddrop = 150
max_hp = (550 * ((KeyCont.players / 2) + 0.5))
max_hp *= (1 + (GameCont.loops / 3))
meleedamage = 200
size = 4
hit_id = 22
instance_create((x - 48), y, PortalClear)
instance_create((x + 48), y, PortalClear)
instance_create(x, (y - 48), PortalClear)
instance_create(x, (y + 48), PortalClear)
spr_idle = sprHyperCrystalIdle
spr_walk = sprHyperCrystalIdle
spr_hurt = sprHyperCrystalHurt
spr_dead = sprHyperCrystalDead
event_inherited()
spr_fire = sprHyperCrystalIdle
snd_hurt = sndHyperCrystalHurt
snd_dead = sndHyperCrystalDead
alarm[1] = (30 + random(90))
cnumber = (3 + (GameCont.loops * 2))
crystals = 0
fastspin = 0
nospin = 0
angle = 0
intro = 0
dist = 0
wantdist = 0
sndhalfhp = 0
sndlowhp = 0
sndtaunt = 0
tauntdelay = 0

spr_shadow = shd64
spr_shadow_y = 16