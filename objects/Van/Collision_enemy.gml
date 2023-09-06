if lockstep_stop
	exit

if meleedamage {
    with other {
        snd_play(other.snd_mele)
        sprite_index = spr_hurt
        image_index = 0
        snd_play_hit_big(other.snd_hurt, 0.2)
        hp -= (other.meleedamage / 10)
        inframes = 5
    }
}