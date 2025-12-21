if lockstep_stop
	exit

var _wrists = scr_skill_get(mut_impact_wrists)

if size >= other.size - 1 && speed > 2 && scr_can_hit(other.id) {
	var _damage = round(other.speed * 0.2) + (_wrists ? 2 : 1)
	
    with other {
        scr_hit_self(_damage)
		motion_add(other.direction, other.speed / 2)
        snd_play_hit(snd_hurt, 0.2)
    }

    if _wrists {
        instance_create(x, y, ImpactWrists)
		snd_play_hit(sndImpWristHit, 0.2)
		
        if !other.hp {
            snd_play_hit(sndImpWristKill, 0.2)
        }
    }
	
    speed *= 0.5
}