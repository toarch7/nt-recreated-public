if instance_exists(DailyList) exit

if UberCont.cgot[num] or UberCont.weekly_run {
    if !selected {
        var inst = playerinstance_get()
        var race = num

        with CharSelect {
            selected = id == other.id
        }

        inst.race = race
        inst.skin = save_get_val("cskin", string(race), 0)

        if !UberCont.daily_run {
            inst.cwep = save_get_val("cswep", string(race), 0) ? UberCont.cwep[race] : UberCont.race_swep[race]
        } else if !UberCont.weekly_run {
            inst.cwep = race_swep[race]
        }

        with GoButton {
            image_speed = 0.4
            image_index = 0
        }

        snd_slct = asset_get_index("sndMutant" + string(race) + "Slct")

        if num == 13 {
            snd_slct = sndBigDogIntro
        }

        if num >= 13 && num <= 15 {
            with Menu {
                loadout = 0
            }
        }

        with Menu
        port_x = 150

        snd_play(snd_slct)

        if global.coop {
            buffer_seek(global.buffer, buffer_seek_start, 0)
            buffer_write(global.buffer, buffer_u8, event.update_playerinstance)
            buffer_send(inst.write(global.buffer))
        }
    } else if (global.coop && global.is_server) or!global.coop {
        scrRunStart()
    }
}

if !UberCont.cgot[num] {
    with Menu {
        alarm[11] = 90
        hint = "locked#" + race_lock[other.num]
    }
}