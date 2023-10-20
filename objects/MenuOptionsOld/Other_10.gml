/// @description Render & logic

if ingame {
    draw_set_color(c_black)
    draw_set_alpha(0.7)
    draw_rectangle(0, 0, view_width, view_height, 0)
    draw_set_color(c_white)
    draw_set_alpha(1)
}

draw_set_valign(fa_center)
draw_set_halign(fa_center)

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

if rp_warning {
    draw_text_nt(view_width / 2, view_height / 2 - 44, loc("@yWARNING"))

    // resourcepack warning
	draw_set_font(fntSmall)
    draw_text_nt(view_width / 2, view_height / 2 - 16, loc("@sRESOURCEPACKS ARE ONLY UNIQUE TO THIS RECREATION.#THEY ARE MADE BY COMMUNITY, ONLY TO MAKE THE GAME#LOOK FRESH IF YOU'VE GOT BORED.##USING RESOURCEPACKS WASN'T INTENDED BY CREATORS,#SO IT MAY AFFECT YOUR EXPERIENCE."))
    draw_set_font(fntM1)

    if rp_warning < 90 {
        draw_text_nt(view_width / 2, view_height / 2 + 16, "@sOK (" + string(ceil((90 - rp_warning) / 30)) + "S.)")
    }
	else draw_text_nt(view_width / 2, view_height / 2 + 16, "OK")

    if rp_warning < 90
		rp_warning ++

    if mouse_check_button_released(mb_left) && rp_warning >= 90 && point_in_circle(mx, my, view_width / 2, view_height / 2, 16) {
        snd_play(sndClickBack)
        save_set_value("etc", "rp_warning", 1)
        rp_warning = 0
    }

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
	
    exit
}

if erasing_progress {
    if self[$ "funnysound"] != undefined or alarm[1] {
        with MusCont {
            if alarm[0] < 5 {
                alarm[0] = 5
            }
        }

        draw_set_color(c_black)
        draw_rectangle(0, 0, view_width, view_height, 0)
        draw_set_color(c_white)

        if alarm[1] exit
    }

    draw_set_valign(fa_top)
    draw_set_color(c_ltgray)
    draw_text_shadow(view_width / 2, 8, erasing_progress == 2 ? loc("RESET OPTIONS") : loc("ERASE PROGRESS"))

    var _x = 0,
        _y = 0

    if erasing_progress == 1 && self.press > 2 {
        _x = orandom(self.press - 2)
        _y = orandom(self.press - 2)
    }

    var o = 32

    if erasing_progress == 2 {
        draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + _y, loc("@wWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET#ALL OF YOUR PREFERENCES.###ARE YOU SURE?@w"))
    } else draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + _y, loc("@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS UNDOABLE.###ARE YOU SURE?@w"))

    draw_text_nt(view_width / 2, view_height / 2 + o, (wait ? "@d" : "@w") + loc("YES") + (erasing_progress == 1 ? " (" + string(5 - self.press) + ")" : ""))
    draw_text_nt(view_width / 2, view_height / 2 + o + 16, (wait ? "@d" : "@w") + loc("NO"))

    if self.press >= 5 or (erasing_progress == 2 && self.press > 0) {
        if erasing_progress == 2 {
            with MenuOptions {
                foreach(options, function(val) {
                    for (var i = 0; i < array_length(val); i ++) {
                        var v = val[i];

                        if !is_undefined(v[$ "value"]) && !is_undefined(v[$ "group"]) {
                            ds_map_delete(UberCont.saveData, v.group + "_" + v.key)
                        }
                    }
                })

                save_set_value("etc", "rp_warning", 0)

                event_perform(ev_create, 0)

                scrOptionsUpdate()
                scrSave()

                snd_play(sndMenuClick)
                snd_play(sndMutant0Cnfm)

                break
            }
        } else {
            if alarm[1] == -1 alarm[1] = 60

            with BackButton
            instance_destroy()

            if self[$ "funnysound"] != undefined {
                audio_stop_sound(self[$ "funnysound"])
                self[$ "funnysound"] = undefined
            }

            audio_stop_all()
        }
    } else {
        if mouse_check_button_released(mb_left) {
            if !wait {
                if point_in_rectangle(mx, my, view_width / 2 - 10, view_height / 2 + o - 8, view_width / 2 + 10, view_height / 2 + o + 8) {
                    snd_play(sndClick)
                    wait = 30

                    self.press ++

                    if erasing_progress == 1 && self.press == 3 {
                        with SpiralCont
                        visible = 0

                        with MusCont {
                            audio_pause_sound(song)
                            audio_pause_sound(amb)
                        }

                        self[$ "funnysound"] = audio_play_sound(sndNothingSielence, 1000, 1)
                        audio_sound_pitch(self[$ "funnysound"], 0.5)
                    }
                }

                if point_in_rectangle(mx, my, view_width / 2 - 10, view_height / 2 + o + 12, view_width / 2 + 10, view_height / 2 + o + 20) {
                    snd_play(sndClickBack)
					
                    if self[$ "funnysound"] != undefined {
                        with SpiralCont
                        visible = 1

                        __background_set_colour(c_black)

                        with MusCont {
                            audio_resume_sound(song)
                            audio_resume_sound(amb)
                        }


                        audio_stop_sound(self[$ "funnysound"])
                        self[$ "funnysound"] = undefined
                    }

                    erasing_progress = 0
                    self.press = 0
                }
            }
        }

        if wait > 0
			wait --
    }

    draw_set_halign(fa_left)

    exit
}

draw_set_color(c_ltgray)
draw_text_shadow(view_width / 2, 8, category == 5 ? loc("RESOURCEPACKS") : loc("SETTINGS"))

if sliderheld {
    sliderheld --

    if !sliderheld {
        snd_play(sndSliderLetGo)
    }
}

if editing_mode {
    if UberCont.opt_gamepad {
        var keynames = variable_struct_get_names(remap_keys)
        if remap_pos >= array_length(keynames) {
            remap_pos = 0
        }

        var keyname = keynames[remap_pos]
        var input = scrGamepadAnykey()

        var text = "[PRESS KEY]"

        if (get_timer() / 1000000) % 2 == 0 {
            text = ""
        }

        draw_text_nt(view_width / 2, view_height / 2, remap_keys[$ keyname] + " @s(" + scrGamepadKeyName(gpad[$ keyname]) + ")#:" + text)

        if input {
            remap_pos ++
			
			gpad[$ keyname] = input

            if remap_pos >= array_length(keynames) {
                var names = variable_struct_get_names(gpad)

                for (var i = 0; i < array_length(names); i++) {
                    var name = names[i]
                    save_set_value("gamepadkey", name, gpad[$ name])
                }

                editing_mode = 0
                snd_play(sndMenuClick)
            }
			else snd_play(sndHover)
        }
    }
	
	pointed_item = -1

    exit
}

if instance_exists(ResourcepackManager) exit

var dx = view_width / 2
var dy = view_height / 2 - 48

var press = mouse_check_button_released(mb_left) or (UberCont.opt_gamepad && gamepad_button_check_pressed(0, gp_face1))

var yoff = 6
if category == 0 {
    yoff = 0
}

if gamepad_button_check_pressed(0, gp_padd) {
    pointed_item ++
	
    if pointed_item >= array_length(options[category]) {
        pointed_item = 0
    }

    snd_play(sndHover)
}
else if gamepad_button_check_pressed(0, gp_padu) {
    pointed_item --

    if pointed_item < 0 {
        pointed_item = array_length(options[category]) - 1
    }

    snd_play(sndHover)
}

for (var i = 0; i < array_length(options[category]); i ++) {
    var opt = options[category, i]

    if opt == undefined
		continue

    var c = 1 + (!is_undefined(opt.name) ? string_count(opt.name, "#") : 0)
    varh = string_height(opt.name)

    draw_set_valign(fa_center)

    switch opt.type {
        case "category":
            var v = 24

            if i >= 4 v = 16

            dy = view_height / 2 - (round(array_length(options[category]) / 2) * v) + i * v + 18

            if i >= 4 dy += 12

            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx - 60, dy - v * 0.4, dx + 60, dy + v * 0.4)

            if is_undefined(opt[$ "splat"]) {
                opt.splat = 0
            }

            opt.splat = lerp(opt.splat, pointed * 4, 0.4)

            if pointed && pointed_item != i {
                snd_play(sndHover)
                pointed_item = i
            }

            dy -= pointed_item == i

            if opt.splat > 0 {
                draw_sprite(sprMenuButtonSplat, opt.splat, dx - 16, dy - 6)
            }

            if opt.value < 5 {
				var name = scrMenuButtonName(sprOptionButtons, opt.value - 1)
				
				if loc_exists(name) {
					draw_bigname(dx, dy, loc(name), pointed ? c_white : c_ltgray)
				}
				else {
	                draw_sprite_ext(sprOptionButtons, opt.value - 1, dx + 1, dy + 1, 1, 1, 0, c_black, 1)
	                draw_sprite_ext(sprOptionButtons, opt.value - 1, dx, dy + 1, 1, 1, 0, c_black, 1)
	                draw_sprite_ext(sprOptionButtons, opt.value - 1, dx, dy, 1, 1, 0, pointed ? c_white : c_ltgray, 1)
				}
            }
			else {
                if pointed draw_set_color(c_white)
                else draw_set_color(c_silver)

                draw_set_halign(fa_center)
                draw_set_valign(fa_center)
                draw_text_shadow(dx, dy, loc(opt.name))
                draw_set_halign(fa_left)
                draw_set_valign(fa_top)
            }

            if press && pointed && clickable && !wait {
                if opt[$ "onClick"] == undefined or scrReal(opt[$ "onClick"]()) {
                    snd_play(sndClick)
                    category = opt.value
                    wait = 5
					
					if category == 5
						category = 0

                    pointed_item = 0
                }
            }
            break

        case "slider":
            dx -= 4

            h = string_height(opt.name) * c + 15
            dy = view_height / 2 - (round(array_length(options[category]) / 2) * h) + i * h - 4
            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx, dy - 10, dx + 16 + UI_SLIDER_WIDTH, dy + 10)

            if pointed_item != i && pointed {
                snd_play(sndHover)
                pointed_item = i
            }

            if pointed_item != i {
                draw_set_color(c_ltgray)
            }
			else dy --

            draw_set_halign(fa_right)
            draw_text_shadow(dx - 4, dy, loc(opt.name) + ": " + string(round(opt.value * 100)) + "%")
            draw_set_halign(fa_left)

            var wdefault = sprite_get_width(sprOptionSlider) - 6
			var w = wdefault * opt.value
			var h = sprite_get_height(sprOptionSlider)
			draw_sprite(sprOptionSlider, 0, dx + 14, dy)
			draw_sprite_part(sprOptionSlider, 1, 0, 0, w + 1, h + 1, dx + 4, dy - 9)
			draw_sprite(sprSliderEnd, 0, dx + 62 + w - wdefault / 2, dy)

            if pointed && !wait {
                var _v = opt.value
                if UberCont.opt_gamepad {
                    var v = gamepad_button_check(0, gp_padr) - gamepad_button_check(0, gp_padl)

                    if v != 0 {
                        opt.value = clamp(opt.value + v / 100, 0, 1)
                        sliderheld = 2
                    }
                } else if mouse_check_button(mb_left) {
                    if press {
                        snd_play(sndClick)
                    }

                    var startX = dx + 16
                    var endX = dx + 16 + UI_SLIDER_WIDTH

                    var a = endX - startX
                    var b = a - (endX - mx)

                    opt.value = clamp(b / a, 0, 1)
                    sliderheld = 2
                }

                if opt.value != _v {
                    save_set_value(opt.group, opt.key, opt.value)
                    scrOptionsUpdate()
                    show_debug_message(opt.group + "_" + opt.key + " = " + string(opt.value))

                    if !sliderheld {
                        snd_play(sndSlider)
                    }
                }
            }

            dx += 4
            break

        case "button":
            h = string_height(opt.name) * c + 10
            dy = view_height / 2 - (round(array_length(options[category]) / 2) * h) + i * h
            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx - 48, dy - 8, dx + 48, dy + 8)

            if pointed_item != i && pointed {
                snd_play(sndHover)
                pointed_item = i
            }

            draw_set_color(c_white)

            if pointed_item != i {
                draw_set_color(c_ltgray)
            } else dy--

            if press && pointed && !wait {
                if press {
                    snd_play(sndClick)
                }

                if !is_undefined(opt[$ "onClick"]) {
                    opt.onClick()
                }

                if !is_undefined(opt[$ "value"]) {
                    save_set_value(opt.group, opt.key, opt.value)
                    scrOptionsUpdate()
                    show_debug_message(opt.group + "_" + opt.key + " = " + string(opt.value))
                }
            }

            if is_undefined(opt[$ "onDraw"]) {
                if !is_undefined(opt[$ "value"]) {
                    draw_set_halign(fa_right)
                    draw_text_shadow(dx - 4, dy, loc(opt.name) + ": ")

                    draw_set_halign(fa_left)
                    draw_sprite(sprScoreSplat, 2, dx + 32, dy)
                    draw_text_shadow(dx + 32, dy, loc(opt.value))
                } else {
                    draw_set_halign(fa_center)
                    draw_text_shadow(dx, dy, loc(opt.name))
                    draw_set_halign(fa_left)
                }
            } else opt.onDraw(dx, dy)
            break

        case "switch":
            h = string_height(opt.name) * c + 10
            dy = view_height / 2 - (round(array_length(options[category]) / 2) * h) + i * h
            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx - 48, dy - 8, dx + 48, dy + 8)

            if pointed_item != i && pointed {
                snd_play(sndHover)
                pointed_item = i
            }

            draw_set_color(c_white)

            if pointed_item != i {
                draw_set_color(c_ltgray)
            }
			else dy--

            draw_set_halign(fa_right)
            draw_text_shadow(dx - 4, dy, loc(opt.name) + ": ")

            draw_set_halign(fa_center)
            draw_sprite(sprScoreSplat, 2, dx + 32, dy)

            if is_undefined(opt[$ "invert"]) {
                if !is_undefined(opt[$ "states"]) {
                    draw_text_shadow(dx + 32, dy, opt.states[opt.value])
                }
				else draw_text_shadow(dx + 32, dy, loc(opt.value ? "ON" : "OFF"))
            }
			else draw_text_shadow(dx + 32, dy, loc(opt.value ? "OFF" : "ON"))

            draw_set_halign(fa_left)

            if press && pointed && !wait {
                snd_play(sndClick)

                if !is_undefined(opt[$ "value"]) {
                    opt.value = !opt.value
                    save_set_value(opt.group, opt.key, opt.value)
                    scrOptionsUpdate()
                    show_debug_message(opt.group + "_" + opt.key + " = " + string(opt.value))
                }
            }
            break

        case "list":
            h = string_height(opt.name) * c + 10
            dy = view_height / 2 - (round(array_length(options[category]) / 2) * h) + i * h
            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx - 48, dy - 8, dx + 48, dy + 8)

            if pointed_item != i && pointed {
                snd_play(sndHover)
                pointed_item = i
            }

            draw_set_color(c_white)

            if pointed_item != i {
                draw_set_color(c_ltgray)
            } else dy--

            var list = opt.list

            draw_set_halign(fa_right)
            draw_text_shadow(dx - 4, dy, loc(opt.name) + ":")

            draw_set_halign(fa_center)
            draw_sprite(sprScoreSplat, 2, dx + 32, dy)
            draw_text_shadow(dx + 32, dy, string_upper(opt.value))
            draw_set_halign(fa_left)

            if press && pointed && !wait {
                snd_play(sndClick)

                opt.pos++

                if opt.pos >= array_length(list) {
                    opt.pos = 0
                }

                opt.value = opt.list[opt.pos]

                save_set_value(opt.group, opt.key, opt.value)
                scrOptionsUpdate()

                show_debug_message(opt.group + "_" + opt.key + " = " + string(opt.value))
            }
            break

        case "input":
            h = string_height(opt.name) * c + 10
            dy = view_height / 2 - (round(array_length(options[category]) / 2) * h) + i * h
            var pointed = (UberCont.opt_gamepad && pointed_item == i) or point_in_rectangle(mx, my, dx - 48, dy - 8, dx + 48, dy + 8)

            if pointed_item != i && pointed {
                snd_play(sndHover)
                pointed_item = i
            }

            draw_set_color(c_white)

            if pointed_item != i {
                draw_set_color(c_ltgray)
            } else dy--

            draw_set_halign(fa_right)
            draw_text_shadow(dx - 4, dy, loc(opt.name) + ":")

            draw_set_halign(fa_center)
            draw_sprite(sprScoreSplat, 2, dx + 32, dy)
            draw_text_shadow(dx + 32, dy, string_upper(opt.value))
            draw_set_halign(fa_left)

            if press && pointed && !wait {
                var req = get_string_async(opt.message, opt.value)

                MenuOptions.async_options[$ string(req)] = [opt.group, opt.key, opt.callback, opt]
            }
            break

        default:
            dy = view_height / 2 - (round(array_length(options[0]) / 2) * h) + i * h
            draw_sprite(sprScoreSplat, 2, dx, dy)
            draw_text_shadow(dx, dy, opt.name + " (" + opt.type + ")")
            break
    }

    draw_set_valign(fa_top)
}

draw_set_color(c_white)
draw_set_halign(fa_left)

if (mouse_check_button_released(mb_left) or gamepad_button_check_pressed(0, gp_face1)) && clickable && wait {
    wait = 0
}