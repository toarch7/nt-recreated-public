if other.object_index == Van
	exit

with other {
    hp -= 6
    snd_play(sndGammaProc)
    sprite_index = spr_hurt
    image_index = 0
    motion_addm(point_direction(other.x, other.y, x, y), 3)
}

if other.hp <= 0 {
    sprite_index = sprGammaBlast
    image_index = 0
	
    with enemy {
        if distance_to_object(other) <= 12 && !inframes {
            hp -= 8
            inframes = 5
            snd_play(snd_hurt)
            sprite_index = spr_hurt
        }
    }

    image_alpha = 0.2
    snd_play(sndGammaKill)
}