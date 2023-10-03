var index = global.index

input_tick()

if splat_index < 3 && paused
    splat_index++

for (var i = 0; i < KeyCont.players; i++) {
	if want_pause
		break
	
    if KeyCont.press_paus[i] && !instance_exists(GenCont) && !instance_exists(Credits) && !instance_exists(Cinematic) {
        if !paused {
            if instance_exists(Player) {
                paused = true
                want_pause = 2
				
				if os_type == os_android && opt_volumecontrol
					SetVolumeControl(false)
				
				scrGetPauseImage()
				
                splat_index = 0
				
				if opt_pauseonpause
					audio_pause_all()
				
				audio_resume_sound(sndMenuClick)
				audio_resume_sound(sndHover)

                with MusCont {
                    if audio_exists(song)
						audio_resume_sound(song)

                    if audio_exists(amb)
						audio_resume_sound(amb)
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
                    event_user(0)
                }
            }
        }

        break
    }
}

// uhhh
KeyCont.press_paus[index] =
		   keyboard_check_pressed(vk_escape)
		or keyboard_check_pressed(vk_backspace)
		or gamepad_button_check_pressed(0, gp_start)
		or (opt_autopause && !paused && !want_pause && (global.desktop ? !window_has_focus() : os_is_paused()))

if global.console_active
	KeyCont.press_paus[index] = 0

if want_restart && !lockstep_stop {
	want_restart --
	
	KeyCont.press_paus[index] = false
	
	if !want_restart {
		instance_activate_all()
		draw_enable_drawevent(true)
		
		random_set_seed(global.seed)
	    global.seed = irandom(rng_m)
		
	    continued_run = 0
	    file_delete("gamestate.dat")
		
		scrInstancesCleanup()
		
	    instance_create(0, 0, GameCont)
		
	    GameCont.crown = global.crownpick
	    GameCont.skillpoints = 0
		
	    scrSpawnPlayers(global.index)
		
	    with MusCont {
			instance_destroy()
		}
		
	    instance_create(0, 0, MusCont)
		
	    room_restart()
		
	    GameCont.area = 1
	    GameCont.subarea = 0
		
	    with WepPickup
			instance_destroy()
		
		instance_create(x, y, GenCont)
		
		paused = false
		
	    want_restart = 0
	}
}

if want_menu && !lockstep_stop {
	want_menu --
	
	KeyCont.press_paus[index] = false
	
	if !want_menu {
	    //scrSave()
		instance_activate_all()
		draw_enable_drawevent(true)
		
		scrInstancesCleanup()
		
	    audio_stop_all()
		
	    file_delete("gamestate.dat")
	    continued_run = 0
		
	    room_restart()
		
	    want_menu = 0
	    want_menu2 = 1
	}
}

if !lockstep_stop && !paused {
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

audio_emitter_gain(mainsound, UberCont.opt_sndvol * mainvol)

camera_set_view_pos(view_camera, view_xview, view_yview)

if opt_prtcls {
    with Smoke instance_destroy()
    with Dust instance_destroy()
    with Drip instance_destroy()
    with Debris instance_destroy()
    with RainSplash instance_destroy()
}

global.time ++

if paused && !global.console_active && instance_exists(PauseButton) {
	if keyboard_check_pressed(ord("R")) {
		with PauseButton {
			if image_index == 1 or image_index == 6 {
				event_user(0)
				
				KeyCont.press_paus[index] = 0
				break
			}
		}
	}
	
	if keyboard_check_pressed(vk_escape) or keyboard_check_pressed(vk_backspace) {
		with PauseButton {
			if image_index == 3 {
				event_user(0)
				
				KeyCont.press_paus[index] = 0
				break
			}
		}
	}
}

if opt_gamepad
	scrGamepadUIControl()

if !paused && !want_pause && !instance_exists(PauseButton) {
	scrHandleInputsGeneral(global.index)
	
	if instance_exists(CoopController) {
		with CoopController
			event_user(0)
	}
}

playerinstance = playerinstance_get(index)