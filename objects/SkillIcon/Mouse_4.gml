if selected {
    event_user(0)

    if instance_exists(CoopController) {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.skillpick)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, skill)
        buffer_send(global.buffer)
    }
} else {
    LevCont.splat = 1
    snd_play(sndMenuSelect)
    with SkillIcon selected = (id == other.id)

    if instance_exists(CoopController) && selected {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.skillselect)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, skill)
        buffer_send(global.buffer)
    }
}