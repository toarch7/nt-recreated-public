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

if instance_exists(CoopController) {
    buffer_seek(global.buffer, buffer_seek_start, 0)
    buffer_write(global.buffer, buffer_u8, event.hitmekill)
    buffer_write(global.buffer, buffer_string, string(index))
    buffer_write(global.buffer, buffer_string, string(x))
    buffer_write(global.buffer, buffer_string, string(y))
    buffer_write(global.buffer, buffer_string, string(direction))
    buffer_write(global.buffer, buffer_string, string(speed))
    buffer_write(global.buffer, buffer_string, string(hp))
    buffer_send(global.buffer)
}