if selected {
    event_user(0)

    if instance_exists(CoopController) && selected {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.ultrapick)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, num)
        buffer_send(global.buffer)
    }
} else {
    LevCont.splat = 1

    with UltraIcon {
        selected = (id == other.id)
    }

    if instance_exists(CoopController) && selected {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.ultraselect)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, num)
        buffer_send(global.buffer)
    }
}