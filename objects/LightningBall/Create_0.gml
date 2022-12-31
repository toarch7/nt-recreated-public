event_inherited()
typ = 1
dmg = 40
hit_id = -1
snd = sndLightningCannonLoop
snd_loop(snd)
if instance_exists(Player) {
    if skill_get(17) dmg = 50
}
alarm[0] = 200
image_speed = 0.5
friction = 0.025