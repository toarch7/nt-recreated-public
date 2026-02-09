event_inherited()

typ = 0
image_yscale = 1.2

if object_index != EnemyLaser {
    if scr_skill_get(mut_laser_brain) image_yscale = 1.6
}

img = 0
damage = 2
alarm[0] = 1

spr_start = sprLaserStart
spr_end = sprLaserEnd