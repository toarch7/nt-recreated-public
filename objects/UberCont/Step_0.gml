if opt_console && !instance_exists(Console) {
    instance_create(0, 0, Console)
}

if splat_index < 3 && paused {
    splat_index++
}

if want_restart {
	instance_activate_all()
	
    if instance_exists(CoopController) && global.is_server {
        global.seed = irandom(rng_m)
        random_set_seed(global.seed)
    }

    continued_run = 0
    file_delete("gamestate.dat")
	
    scrVolume()
    surface_free(pauseimg)
    sprite_delete(pausespr)
    pausespr = -1
    paused = 0
	
    with all {
        if object_index != UberCont && object_index != Console && object_index != CoopController {
            instance_destroy(id, 0)
        }
    }
	
    instance_create(0, 0, GameCont)
	
    GameCont.crown = global.crownpick
    GameCont.skillpoints = 0

    scrSpawnPlayers(global.index)

    scrRaces()
    scrCrowns()

    if !daily_run or weekly_run {
        with MusCont {
			instance_destroy()
		}
		
        instance_create(0, 0, MusCont)

        room_restart()
        GameCont.area = 1
        GameCont.subarea = 0

        with WepPickup {
			instance_destroy()
		}
    }

    instance_create(x, y, GenCont)

    want_restart = 0
}

for (var i = 0; i < KeyCont.players; i++) {
    if KeyCont.press_paus[i] && !instance_exists(GenCont) && !instance_exists(Credits) && !instance_exists(Cinematic) {
        if !paused {
            if instance_exists(Player) {
                want_pause = 1
                paused = 1
                getpauseimg = 1
                splat_index = 0
				
                pauseRace = GameCont.race

                audio_pause_all()

                with MusCont {
                    if sound_exists(song) audio_resume_sound(song)

                    if sound_exists(amb) audio_resume_sound(amb)
                }

                with Player {
                    playerinstance_get(index).hp = hp
                }

                KeyCont.press_paus[i] = 0
            }
        }
		else {
            with PauseButton {
                if image_index == 3 {
                    clicked = 1
                    event_perform(ev_mouse, ev_left_release)
                }
            }
        }

        break
    }
}

KeyCont.press_paus[global.index] = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace) or gamepad_button_check_pressed(0, gpad.start) or(!global.pc_build && os_is_paused())

if want_menu2 {
    //scrSave()
	instance_activate_all()
	
    with GameCont {
        ds_list_clear(skills)
    }

    with hitme
    instance_destroy()

    with all {
        if object_index != UberCont && object_index != Console && object_index != BackCont {
            instance_destroy(id, 0)
        }
    }

    if instance_exists(BackCont) {
        BackCont.persistent = 0
    }

    audio_stop_all()

    file_delete("gamestate.dat")
    continued_run = 0

    room_restart()

    want_menu = 1
    want_menu2 = 0
}

if !lockstep_stop {
    ds_list_clear(UPDATE_WALLS)

    with Wall {
        if x > view_xview - 32 && y > view_yview - 32 && x < view_xview + view_width + 32 && y < view_yview + view_height + 32 {
            ds_list_add(UPDATE_WALLS, id)
        }
    }

    ds_list_clear(global.floor_screen)

    with Floor {
        if x > view_xview - 32 && y > view_yview - 32 && x < view_xview + view_width + 32 && y < view_yview + view_height + 32 {
            ds_list_add(global.floor_screen, id)
        }
    }

    if instance_exists(Cinematic) {
        ds_list_clear(UPDATE_WALLS)

        with Wall {
            ds_list_add(UPDATE_WALLS, id)
        }
    }
}

if mainvol < 1 {
    mainvol = lerp(mainvol, 1, .4)
}

audio_emitter_gain(mainsound, mainvol)

camera_set_view_pos(view_camera, view_xview_val, view_yview_val)

if opt_prtcls {
    with Smoke instance_destroy()
    with Dust instance_destroy()
    with Drip instance_destroy()
    with Debris instance_destroy()
    with RainSplash instance_destroy()
}

global.time ++

if paused && instance_exists(PauseButton) {
	if keyboard_check_pressed(ord("R")) {
		with PauseButton {
			if image_index == 1 or image_index == 6 {
				event_perform(ev_mouse, ev_left_release)
				break
			}
		}
	}
}