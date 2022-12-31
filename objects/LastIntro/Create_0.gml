max_hp = 1
size = 1
spr_idle = sprDeskIdle
spr_hurt = sprDeskIdle
spr_dead = sprDeskDead
event_inherited()
transtime = 0

if instance_exists(Cinematic) instance_create(x - 40, y + 32, Messenger)