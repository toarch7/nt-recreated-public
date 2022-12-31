if other.team != team {
    with other {
        if !inframes {
            with other
            instance_destroy()
            snd_play_hit(snd_hurt, .2)
            inframes = 5
            if object_index == Player last_hit = other.hit_id hp -= 5 sprite_index = spr_hurt image_index = 0 sleep(10) BackCont.shake += 1
        }
    }
}