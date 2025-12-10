event_inherited()
typ = 1
damage = 40
snd = sndLightningCannonLoop
snd_play_loop(snd)

if instance_exists(Player) {
    if scr_skill_get(mut_laser_brain) dmg = 50
}

alarm[0] = 200
image_speed = 0.5
friction = 0.025