instance_create(x, y, Nothing2Death)
with(MusCont)
alarm[1] = 1

with projectile {
    if team != 2 instance_destroy()
}

snd_play_hit_big(sndNothing2DeadStart, 0.2)

repeat 2
scrDrop(100, 0)

scrAchievement(34)

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