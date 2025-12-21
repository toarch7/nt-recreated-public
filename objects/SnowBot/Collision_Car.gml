if lockstep_stop
	exit

with other {
    instance_change(Wind, false)
    event_perform(ev_create, 0)
}
alarm[1] = 40

snd_play(sndSnowBotPickup)

if other.spr_idle == sprFrozenCar {
	is_red_car = false
	spr_idle = sprSnowBotCarLift
	spr_walk = sprSnowBotCarWalk
	spr_hurt = sprSnowBotCarHurt
}
else {
	is_red_car = true
	spr_idle = sprSnowBotRedCarLift
	spr_walk = sprSnowBotRedCarWalk
	spr_hurt = sprSnowBotRedCarHurt
}

meleedamage = 0
alarm[2] = 4 / 0.4
sprite_index = spr_idle
speed = 0
walk = 0
image_index = 0
instance_change(SnowBotCar, false)

sleep(20)