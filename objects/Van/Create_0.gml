raddrop = 0
max_hp = 250
meleedamage = 20
size = 7
hitid = HitId.Van
name = "VAN"
spr_idle = sprVanDrive
event_inherited()
team = 3
spr_walk = sprVanDrive
spr_hurt = sprVanHurt
spr_dead = sprVanDead
snd_hurt = sndVanHurt
right = choose(1, -1)

var _target = instance_nearest(x, y, Player)

if (instance_exists(_target) && x != _target.x) {
	right = sign(_target.x - x)
}

drive = true
wallbreak = 24
drivespeed = 8
alarm[0] = 40
drawspr = spr_idle
drawimg = 0
freak = 0

if (GameCont.loops > 2 && (GameCont.area != area_campfire || GameCont.loops > 3)) {
	freak = true
}

spr_shadow = shd96
spr_shadow_y = -8

can_hq = (!freak)