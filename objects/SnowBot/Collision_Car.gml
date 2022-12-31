with other {
    instance_change(Wind, false)
    event_perform(ev_create, 0)
}
alarm[1] = 40

snd_play(sndSnowBotPickup)


spr_idle = sprSnowBotCarLift
spr_walk = sprSnowBotCarWalk
spr_hurt = sprSnowBotCarHurt
meleedamage = 0
alarm[2] = 4 / 0.4
sprite_index = spr_idle
speed = 0
walk = 0
image_index = 0
instance_change(SnowBotCar, false)

sleep(20)