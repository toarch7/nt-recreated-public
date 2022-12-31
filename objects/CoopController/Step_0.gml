/*var imprkeys = struct_keys(importantpackets)
if array_length(imprkeys) {
	
}*/

if index != -1 && !instance_exists(CoopMenu) {
    var ind = index,
        b = inputsbuffer

    if instance_exists(Player) {
        buffer_seek(b, buffer_seek_start, 0)
        buffer_write(b, buffer_u8, event.syncplayer)
        buffer_write(b, buffer_u8, ind)
        buffer_write(b, buffer_string, string(KeyCont.dir_move[ind]))
        buffer_write(b, buffer_string, string(KeyCont.dir_fire[ind]))
        buffer_write(b, buffer_f16, KeyCont.moving[ind])
        buffer_write(b, buffer_u8, KeyCont.gamepad[ind])
        buffer_write(b, buffer_u8, KeyCont.aimassist[ind])

        var keys = ["fire", "spec", "pick", "swap", "paus", "horn"]

        for (var i = 0; i < array_length(keys); i++) {
            buffer_write(b, buffer_u8, KeyCont[$ "press_" + keys[i]][ind])
            buffer_write(b, buffer_u8, KeyCont[$ "release_" + keys[i]][ind])
            buffer_write(b, buffer_u8, KeyCont[$ "hold_" + keys[i]][ind])
        }

        buffer_write(b, buffer_u8, KeyCont.crosshair[ind])
        buffer_write(b, buffer_u8, KeyCont.activeforever[ind])

        var p = noone
        with Player
        if is_me {
            p = id
        }

        if instance_exists(p) {
            buffer_write(b, buffer_s8, p.index)
            buffer_write(b, buffer_string, string(p.x))
            buffer_write(b, buffer_string, string(p.y))
            buffer_write(b, buffer_string, string(p.hp))
            buffer_write(b, buffer_u8, p.spirit)
            buffer_write(b, buffer_string, string(p.wep))
            buffer_write(b, buffer_string, string(p.bwep))
            buffer_write(b, buffer_u8, p.curse)
            buffer_write(b, buffer_u8, p.bcurse)

            for (var i = 1; i <= 5; i++) {
                buffer_write(b, buffer_string, string(p.ammo[i]))
            }
        } else {
            buffer_write(b, buffer_s8, - 1)
            buffer_write(b, buffer_string, "0")
            buffer_write(b, buffer_string, "0")
            buffer_write(b, buffer_string, "0")
            buffer_write(b, buffer_u8, 0)
            buffer_write(b, buffer_string, "0")
            buffer_write(b, buffer_string, "0")
            buffer_write(b, buffer_u8, 0)
            buffer_write(b, buffer_u8, 0)

            for (var i = 1; i <= 5; i++) {
                buffer_write(b, buffer_string, "0")
            }
        }

        buffer_send(b)
    }


    with enemy {
        for (var i = 0; i <= 11; i++)
        if alarm[i] alarm[i]++
    }

    if global.is_server {
        ai_seed++

        buffer_seek(b, buffer_seek_start, 0)
        buffer_write(b, buffer_u8, event.syncai)
        buffer_write(b, buffer_u16, ai_seed)

        if ai_seed >= 65535 {
            ai_seed = 0
        }

        random_set_seed(ai_seed)
        var _ai_seed = ai_seed

        buffer_write(b, buffer_string, string(instance_number(enemy)))

        with enemy {
            var a0 = alarm[0],
                a1 = alarm[1],
                a2 = alarm[2]

            for (var i = 0; i <= 11; i++) {
                if alarm[i] {
                    alarm[i]--

                    if !alarm[i] {
                        random_set_seed(_ai_seed)
                        event_perform(ev_alarm, i)
                    }
                }
            }

            buffer_write(b, buffer_string, string(index))
            buffer_write(b, buffer_string, string(x))
            buffer_write(b, buffer_string, string(y))
            buffer_write(b, buffer_string, string(speed))
            buffer_write(b, buffer_string, string(direction))
            buffer_write(b, buffer_string, string(hp))
            buffer_write(b, buffer_string, string(a0 - 1))
            buffer_write(b, buffer_string, string(a1 - 1))
            buffer_write(b, buffer_string, string(a2 - 1))
        }

        buffer_send(b)

        var port = instance_find(Portal, 0)

        if port {
            buffer_seek(global.buffer, buffer_seek_start, 0)
            buffer_write(global.buffer, buffer_u8, event.syncportal)
            buffer_write(global.buffer, buffer_string, string(port.x))
            buffer_write(global.buffer, buffer_string, string(port.y))
            buffer_send(global.buffer)
        }
    } else {
        with enemy {
            x -= hspeed
            y -= vspeed

            if !hp {
                if !isset("_oldmask") _oldmask = mask_index
                mask_index = mskNone
            } else if mask_index == mskNone && isset("_oldmask") {
                mask_index = _oldmask
            }
        }
    }
}