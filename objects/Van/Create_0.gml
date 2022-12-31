raddrop = 0
max_hp = 250
meleedamage = 20
size = 7
hit_id = sprite_index
name = "VAN"
spr_idle = sprVanDrive
event_inherited()
team = 3
spr_walk = sprVanDrive
spr_hurt = sprVanHurt
spr_dead = sprVanDead
snd_hurt = sndVanHurt
right = choose(1, - 1)
if instance_exists(Player) {
    if (Player.x < x) right = -1
    else right = 1
}
drive = 1
break_walls = 24
drivespeed = 8
alarm[0] = 40
drawspr = spr_idle
drawimg = 0
freak = 0
if ((GameCont.loops > 2) && ((GameCont.area != 0) || (GameCont.loops > 3))) freak = 1

spr_shadow = shd96
spr_shadow_y = -8

can_hq = !freak