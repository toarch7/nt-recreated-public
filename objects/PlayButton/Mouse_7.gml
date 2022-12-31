if instance_exists(Logo) or wait or!available exit

global.index = 0
global.hardmode = 0
global.coop = 0
global.is_server = 1

with UberCont {
    daily_run = 0
    weekly_run = 0

    playerinstances[$ string(global.index)] = new PlayerInstance(global.index, 0, 0)
}

switch image_index {
    case 1:
        if os_is_network_connected() {
            if string(UberCont.daily_seed) == save_get_val("etc", "seed", "-1") {
                instance_create(0, 0, DailyList)
                snd_play(sndClick)

                with object_index {
                    instance_destroy()
                }

                exit
            }

            with UberCont {
                daily_run = 1
            }
        } else {
            show_message_async("Please check your network connection")
            image_blend = c_dkgray
            exit
        }
        break

    case 2:
        if os_is_network_connected() {
            with UberCont {
                if is_undefined(weekly_data[? "seed"]) {
                    other.available = 0
                    image_blend = c_dkgray
                    exit
                }

                weekly_run = 1
                daily_run = 1
            }
        } else {
            show_message_async("Please check your network connection")
            image_blend = c_dkgray
            exit
        }
        break

    case 3:
        global.hardmode = 1
        break
}

instance_create(0, 0, GameCont)
instance_create(0, 0, MenuGen)

with MainMenuButton instance_destroy()
with SpiralCont instance_destroy()

with object_index instance_destroy()
snd_play(sndClick)