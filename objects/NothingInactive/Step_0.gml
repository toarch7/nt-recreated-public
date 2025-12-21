if (!active) hp = max_hp

speed = 0
x = xstart
y = ystart

if (hp <= 0) {
	instance_create(x, y, BecomeNothing)
	
	snd_stop(sndBecomeNothingStartup)
	snd_play(sndBecomeNothingHurt)
	snd_stop(sndBecomeNothingIdle)
		
	with MusCont {
	    snd_stop(song)
	    audio_sound_set_track_position(amb, irandom(audio_sound_length(amb)))
	}
		
	flame = sprThroneFlameEnd
	flameanim = 0
	
	for(var i = -1; i <= 1; i += 2) {
		with instance_create(x + 81 * i, y - 38, BulletHit) {
		    sprite_index = sprThroneFlameEnd
		    image_angle = 0
		}
		
		with instance_create(x + 81 * i, y + 18, BulletHit) {
		    sprite_index = sprThroneFlameEnd
		    image_angle = 0
		}
	}
	
	instance_destroy()
}

if (!active && distance_to_object(Player) <= 24) {
    active = true
	
    image_speed = 0.4
	sprite_index = sprNothingSwitchOn
	spr_idle = sprite_index
	spr_hurt = sprite_index
	
    snd_play(sndBecomeNothingStartup)
    snd_play_loop(sndBecomeNothingIdle)

    flame = sprThroneFlameStart
    alarm[0] = 3 / image_speed

    flameanim = 0
}

x = xstart
y = ystart