if lockstep_stop
	exit

if (other.object_index == LilHunter or other.object_index == Salamander) && team == other.team {
    exit
}

var immune = 0

if other.team != team && other.team != 0 {
    with other {
        if object_index == Player {
            if skill_get(14) {
                immune = 1
            }
        }

        if !inframes && sprite_index != spr_hurt {
            snd_play_hit(snd_hurt, .2)

            if immune {
                if hp > 4 {
                    if hp - 1 < 4 {
                        hp = 4
                    } else hp -= 1
                }
            } else {
                hp -= 1
                inframes = 5
            }

            sprite_index = spr_hurt
            image_index = 0

            BackCont.shake += 3
        }
    }
} else if sprite_index != sprFireLilHunter {
    x = xprevious
    y = yprevious
}

if hit_id > 0 {
    other.last_hit = hit_id
}