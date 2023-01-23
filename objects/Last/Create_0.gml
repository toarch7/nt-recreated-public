raddrop = 0
max_hp = 1100
max_hp *= 1 + GameCont.loops / 3
meleedamage = 10
size = 6
hit_id = sprLastIdle
intro = 0
spr_idle = sprLastIdle
spr_walk = sprLastIdle
spr_hurt = sprLastHurt
spr_dead = sprLastHurt
drawspr = spr_idle
drawimg = 0
event_inherited()
snd_hurt = sndLastHurt
snd_dead = sndLastDeath
walk = 0
ammo = 0
attacktype = 0
introcharge = 0
gunangle = random(360)
charge = 0
alarm[1] = 1
with(instance_create(x, y, PopoExplosion)) {
    team = other.team
    hit_id = other.hit_id
}
wkick = 0
scrTarget()

if instance_exists(target) {
    gunangle = target_direction
}

corpse = 0
sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0

spr_shadow = shd48