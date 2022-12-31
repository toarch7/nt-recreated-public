spr_idle = sprDeskIdleWait

if instance_exists(Cinematic) {
    spr_idle = sprDeskIdleTurn
    snd_play(sndTurnChair)
}

sprite_index = spr_idle
image_index = 0