instance_create(x, y, NothingDeath)

with MusCont {
    alarm[1] = 1
}

snd_play(sndNothingDeath1)
scrAchievement(33)
audio_stop_sound(sndNothingBeamLoop)

with enemy {
    hp = 0
}

with projectile {
    if team == other.team {
        instance_destroy()
    }
}

with Guardian {
    instance_destroy()
}

with BigGenerator {
    instance_destroy(id, 0)
    instance_create(x, y, BigGeneratorInactive)
}
