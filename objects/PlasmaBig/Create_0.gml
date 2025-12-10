event_inherited()

typ = 1

damage = 15

if instance_exists(Player) {
    if scr_skill_get(mut_laser_brain) image_xscale += 0.2
}

image_speed = 0.5
sleep(100)
