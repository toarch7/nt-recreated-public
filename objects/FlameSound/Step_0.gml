if instance_exists(FlameBurst) timeout = 0
else {
    timeout += 1
    if timeout > 1 {
        snd_stop(sndFlamerLoop)
        snd_play(sndFlamerStop)
        instance_destroy()
    }
}