alarm[3] = 10

if instance_exists(enemy) {
    var ind = -1

    with enemy {
        if !hp or enemy_find_index(index) == undefined {
            ind = index
            break
        }
    }

    if ind != -1 {
        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.verifyenemy)
        buffer_write(global.buffer, buffer_string, string(ind))
        buffer_send(global.buffer)

        debugstr = "weird fuckah " + string(ind)
    }
}