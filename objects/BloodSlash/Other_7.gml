instance_destroy()
if !isset("creator") creator = instance_nearest(x, y, Player)
if !hitted {
    with creator {
        hp--sprite_index = spr_hurt
        snd_play_hit(snd_hurt, .2)
        last_hit = sprBloodHammer
    }
}