if splat_index < 3 && paused {
    splat_index++
}

if want_restart {
	instance_activate_all()
	
	random_set_seed(global.seed)
    global.seed = irandom(rng_m)
    
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
	
	with Player
		instance_destroy(id, 0)
	
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
				
				audio_resume_sound(sndMenuClick)

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
    ds_list_clear(global.lis_walls_visible)

    with Wall {
        if x > view_xview - 32 && y > view_yview - 32 && x < view_xview + view_width + 32 && y < view_yview + view_height + 32 {
            ds_list_add(global.lis_walls_visible, id)
        }
    }

    ds_list_clear(global.floor_screen)

    with Floor {
        if x > view_xview - 32 && y > view_yview - 32 && x < view_xview + view_width + 32 && y < view_yview + view_height + 32 {
            ds_list_add(global.floor_screen, id)
        }
    }

    if instance_exists(Cinematic) {
        ds_list_clear(global.lis_walls_visible)

        with Wall {
            ds_list_add(global.lis_walls_visible, id)
        }
    }
	
	if opt_console && !instance_exists(Console) {
	    instance_create(0, 0, Console)
	}
}

if mainvol < 1 {
    mainvol = lerp(mainvol, 1, 0.4)
}

audio_emitter_gain(mainsound, mainvol)

camera_set_view_pos(view_camera, view_xview, view_yview)

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



// Handle inputs

KeyCont.press_horn[global.index] = 0
KeyCont.gamepad[global.index] = opt_gamepad
KeyCont.keyboard[global.index] = opt_keyboard
KeyCont.aimassist[global.index] = opt_assist

if opt_gamepad {
    scrSetGamepadInputs(global.index)
}
else if opt_keyboard {
    scrSetKeyboardInputs(global.index)

    if localcoop {
        scrSetGamepadInputs(1)
    }
}
else {
	with MobileUI {
		event_user(0)
	}
	
    for (var i = 0; i < array_length(touch_duration); i++) {
        if device_mouse_check_button(i, mb_left) {
            touch_duration[i] ++
        }
		else touch_duration[i] = 0
    }
}

if volqueue != -1 && !ds_queue_empty(volqueue) {
    var a = ds_queue_dequeue(volqueue)
    scrHandleVolumeControl(a[0], a[1])
}

if instance_exists(CoopController) {
	with CoopController {
		event_user(0)
	}
}