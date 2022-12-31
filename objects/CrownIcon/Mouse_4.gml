if isset("appeary") && appeary exit

if selected {
    event_user(0)

    if instance_exists(CoopController) {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.crownpick)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, crown)
        buffer_send(global.buffer)
    }
} else {
    with CrownIcon selected = (id == other.id)
    LevCont.splat = 1

    if instance_exists(CoopController) {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.crownselect)
        buffer_write(global.buffer, buffer_u8, global.index)
        buffer_write(global.buffer, buffer_u8, crown)
        buffer_send(global.buffer)
    }
}