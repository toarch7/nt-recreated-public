if lockstep_stop
	exit

if other.team != team && !other.inframes {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, 0.2)

            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0

            motion_addm(other.direction, 8)

            BackCont.shake += 5

            last_hit = other.hit_id

            inframes = 5
        }
    }

    if guitar {
        var _sound_index = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))
		
        if audio_exists(_sound_index) {
            snd_play_pitch(_sound_index, 0.2)
		}
	}
}