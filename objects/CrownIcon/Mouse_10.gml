if UberCont.opt_keyboard {
    LevCont.splat = 1
    snd_play(sndMenuSelect)
    selected = 1

    if instance_exists(CoopController) {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.crownselect)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, crown)
        buffer_send(global.buffer)
    }
}