function handle_console_command(str) {
	if instance_exists(CoopController) && !CoopController.event_run {
		
		net_add_data("other", "console", str)
		
		exit
	}
	
    var cmdraw = string_split_array(str, " ")
    var cmd = string_split_array(string_lower(str), " ")

    var args = []

    if array_length(cmd) {
        array_copy(args, 0, cmd, 1, array_length(cmd))
    }

    var commands = {
        help: "Definitely helps you",
        wep: "Gives you a weapon",
        spawn: "Spawns something at start coordinates",
        mut: "Grants you mutation",
        rads: "Gain some rads",
        lvl: "Instantly reach level ultra",
        area: "Transit to some area",
        instgen: "Instantenious generation flag",
        killall: "Kills everyone and everything while also preventing portal from spawn",
        mobile: "Enable/disable mobile mode",
        restart: "Restart the run",
        reset: "Reset the game",
        nodeath: "Disable death",
        reload: "Reload all resourcepacks",
        seed: "Set seed, works properly after restart",
		instances: "Display list of existing instances"
    }

    if command_binding {
        printc("Bound \"" + str + "\" to \"P\"", c_yellow)
        printc("Press RMB to discard bind", c_gray)

        bound_command = str
        command_binding = false

        return undefined
    }

    try {
        switch cmd[0] {
            case "help":
                printc("All commands available:", c_yellow)

                var names = struct_keys(commands)
                array_sort(names, true)

                for (var i = 0; i < array_length(names); i++) {
                    var name = names[i]
                    print(name + " - " + variable_struct_get(commands, name))
                }
                break

            case "spawn":
                var o = scrParseSpawn(cmd)

                if object_exists(o) {
                    var c = array_length(cmd) > 1 ? real(cmd[1]) : 1
                    var _x = 10016
                    var _y = 10016

                    if global.desktop && !instance_exists(CoopController) {
                        _x = mouse_x
                        _y = mouse_y
                    }

                    if o == Player {
                        with scrSpawnPlayer(global.index, c, GameCont.bskin) {
                            x = 10016
                            y = 10016

                            visible = 1
                            wep = race_swep[c]
                        }

                        break
                    }

                    repeat c {
                        instance_create(_x, _y, o)
                    }
                } else printc("Cannot create given object", c_red)
                break

            case "lvl":
                GameCont.rad += 9990
                break

            case "reload":
                discard_custom_sprites(1)
                discard_custom_sounds()
                load_resourcepacks()
                break

            case "rads":
            case "rad":
                GameCont.rad += real(args[0])
                break
			
			case "intro":
			case "bossintro":
				scrBossIntro(real(args[0]))
				break
			
			case "unlockscreen":
				with instance_create(x, y, UnlockScreen) {
		            race = irandom(15)
		            skin = irandom(1)
		        }
				break
			
            case "mut":
            case "skill":
                var s = scrContentIdByName(args, GameCont.skill_name)

                if s {
                    skill_set(s, !skill_get(s))
                } else printc("Unknown mut given", c_red)
                break

            case "killall":
                with enemy
                instance_destroy(id, 0)
                with prop
                instance_destroy(id, 0)
                with projectile
                instance_destroy(id, 0)
                with Portal
                instance_destroy(id, 0)
				with IDPDSpawn
                instance_destroy(id, 0)
				with VanSpawn
                instance_destroy(id, 0)

                with Player {
                    if mask_index != mskPlayer {
                        angle = 0

                        sprite_index = spr_idle
                        image_index = 0

                        visible = 1
                        mask_index = mskPlayer
                    }
                }
                break

            case "wep":
            case "weapon":
            case "gun":
                var i = scrContentIdByName(args, wep_name)

                if i != -1 {
                    with Player {
                        ammo[wep_type[i]] = typ_amax[wep_type[i]]

                        var _w = variable_instance_get(id, "_debuglastwep")

                        if wep == _w or !bwep {
                            bwep = i
                        } else wep = i

                        variable_instance_set(id, "_debuglastwep", i)

                        if reload reload = 1
                    }
                } else print("Failed to find given weapon")
                break

            case "nodeath":
            case "nd":
                with Player {
                    can_die = !can_die

                    print(can_die ? "You can now become dead" : "You can no longer become dead")
                }
                break

            case "goto":
            case "area":
                with Player {
                    var m = string_split_array(cmd[1], "-")

                    GameCont.route = 0

                    if string_copy(cmd[1], 1, 2) == "hq" {
                        m[0] = 106
                        m[1] = real(string_delete(cmd[1], 1, 2))
                    } else if cmd[1] == "???"
                    or cmd[1] == "vault" {
                        m[0] = 100
                        m[1] = 1
                    } else if m[1] == "?" {
                        m[0] = 100 + m[0]
                        m[1] = 1
                    } else if m[0] == "hq" {
                        m[0] = 106
                        m[1] = real(m[1])
                    } else if string_count("b", m[0]) {
                        m[0] = string_replace_all(m[0], "b", "")

                        GameCont.route = 1

                        m[0] = real(m[0])
                        m[1] = real(m[1])
                    } else {
                        m[0] = real(m[0])
                        m[1] = real(m[1])
                    }


                    GameCont.area = m[0]
                    GameCont.subarea = m[1] - 1

                    if m[0] % 2 == 0 && m[0] < 100 && m[0] != 106 {
                        GameCont.area = m[0] - 1
                        GameCont.subarea = 3
                    }

                    with GameCont {
                        hard = subarea - 1

                        if area == 0 hard += 0
                        else if area == 1 hard += 1
                        else if area == 2 hard += 3
                        else if area == 3 hard += 4
                        else if area == 4 hard += 7
                        else if area == 5 hard += 8
                        else if area == 6 hard += 11
                        else if area == 7 hard += 12
                        else if area == 100 hard += 6
                        else if area == 101 hard++
                        else if area == 102 hard += 4
                        else if area == 103 hard += 5
                        else if area == 104 hard += 7
                        else if area == 105 hard += 10
                        else if area == 106 hard++
                    }

                    print("Teleporting to " + string(GameCont.area) + "-" + string(GameCont.subarea) + " L" + string(GameCont.loops) + " h: " + string(GameCont.hard))

                    if array_length(cmd) > 2 {
                        GameCont.loops = real(string_replace(cmd[2], "l", ""))
                        GameCont.hard += (GameCont.loops * 16)
                    }
					else GameCont.loops = 0

                    with instance_create(x, y, Portal) {
                        sprite_index = sprPortalDisappear
                        event_perform(ev_other, ev_animation_end)
                    }

                    break
                }
                break

            case "instgen":
                if (flags & 2) == 2 {
                    flags ^= 2
                } else flags |= 2
                break
			
            case "instances":
                if (flags & 4) == 4 {
                    flags ^= 4
                } else flags |= 4
                break

            case "overlay":
                if (flags & 8) == 8 {
                    flags ^= 8
                } else flags |= 8
                break

            case "clear":
                global.log_output = []
                global.log_color = []
                break

            case "mobile":
				
                with UberCont {
					opt_keyboard = !opt_keyboard
					save_set_val("options", "keyboard", opt_keyboard)
					
					print(opt_keyboard ? "Disabled mobile controls" : "Enabled mobile controls")
				}
				
                break

            case "restart":
                with UberCont
                want_restart = 1
                break

            case "reset":
                game_restart()
                break
			
			case "fps":
                game_set_speed(real(args[0]), gamespeed_fps)
                break

            case "seed":
                if args[0] == "none"
                or args[0] == "null"
                or args[0] == "0" {
                    print("Seed has been reset.")

                    break
                }

                try {
                    Console.seed = real(args[0])
                    print("Seed set to " + string(Console.seed))
                }
                catch (e) {
                    printc("Bad value given.", c_red)
                }
                break

            case "close":
                global.console_active = 0
                break

            case "load":
            case "loadmod":
                print(":^) hehe")
                break

            case "exportsprites":
                var p = game_directory + "exportsprites"

                if !directory_exists(p) directory_create(p)

                p += "/"

                for (var i = 0; sprite_exists(i); i++) {
                    sprite_strip_save(i, p + sprite_get_name(i) + ".png")
                }

                print("Exported", i, "sprites")
                break

            case "hard":
                print("Current difficulty:", GameCont.hard)
                break
			
			case "option":
				try {
					UberCont.saveData[? cmd[0]] = real(cmd[1])
					print("real")
					scrOptionsUpdate()
				}
				catch(e) {
					UberCont.saveData[? cmd[0]] = cmd[1]
					scrOptionsUpdate()
				}
				
				break
			
            default:
                return 1
        }
    } catch (e) {
        printc("Console exception: " + e.message, c_red) show_debug_message(e.longMessage)
    }
}