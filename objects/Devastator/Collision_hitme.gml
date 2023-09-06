if lockstep_stop
	exit

if other.team != team && other.hp > 0 {
    with other {
        if object_index == Player last_hit = other.hit_id hp -= 8 sprite_index = spr_hurt image_index = 0 motion_add(other.image_angle, 4) if speed > 16 speed = 16
    }

    snd_play_hit(other.snd_hurt, 0.2)
    instance_create(x, y, Smoke)
}