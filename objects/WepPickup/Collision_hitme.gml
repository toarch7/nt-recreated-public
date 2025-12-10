if lockstep_stop
	exit

if mask_index != mskWepPickup {
    if speed > 4 && team != other.team && instance_exists(Player) {
        with other {
            if !inframes {
                hp -= 15 + 4 * GameCont.level
                sprite_index = spr_hurt
                snd_play_hit(snd_hurt, 0.2)
                inframes = 5
            }
        }

        instance_create(x, y, ThrowHit)

        if !scr_skill_get(5) speed *= 0.2
    }
}