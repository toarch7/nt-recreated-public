with target {
    hp -= other.damage
    snd_play_hit(snd_hurt, .2)
}

instance_destroy()