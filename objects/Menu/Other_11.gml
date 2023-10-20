/// @description Draw loadout

var inst = player_get(global.index),
	yoff = dailylistfavor,
	press = false,
	
	width = gui_w,
	height = gui_h

if inst == undefined
	exit

var prt = sprBigPortrait

if inst.skin
    prt = sprBigPortraitSkin

height ++

draw_sprite(prt, race, -yoff * 4 - port_x - 24, height - 38)

draw_sprite(sprCharSplat, splat_index, round(-yoff * 1.6), round(height - 36))

if loc_exists(race_name[race]) {
	draw_set_valign(fa_center)
	
	draw_bigname(-yoff * 4, height - 60 - (race > 0) * 16, loc(string_upper(race_name[race])), c_white, 1)
	
	draw_set_valign(fa_top)
}
else {
	var _x = -yoff * 4,
		_o = -60 + ((race == 0) * 26)
	
	draw_sprite_ext(sprBigNames, race, _x + 1, height + _o, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprBigNames, race, _x + 1, 2 + height + _o, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprBigNames, race, _x, 2 + height + _o, 1, 1, 0, c_black, 1)
	
	draw_set_color(c_white)
	draw_sprite(sprBigNames, race, _x, height + _o)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if appear < 2
	draw_text_nt(-yoff * 4 + 6, height - 56 + appear, string_replace(loc(race_pass[race]) + "#" + loc(race_acti[race]), ", ", "#"))

height --

if port_x > 0
	port_x = lerp(port_x, 0, 0.8)

if appear
	appear --

if splat_index < 3
	splat_index ++

draw_sprite(sprLoadoutSplat, splat_index, round(yoff + width), round(height - 35))

var canloadout = race != 0

if loadout && canloadout {
    if loadout_frame < 4 {
        loadout_frame ++
    }

    draw_set_color(c_black)
    draw_rectangle(width, height - 32, UberCont.max_view_width, 32, 0)
    draw_set_color(c_white)
}
else if loadout_frame > 0
	loadout_frame --

if loadout_frame > 0
    draw_sprite(sprLoadout, loadout_frame, width, height - 36)



if is_gamepad() {
	if loadout {
		var ah = gamepad_axis_value(0, gp_axislh),
			av = gamepad_axis_value(0, gp_axislv)
		
		if ah != 0 {
			mousex += ah * 8
			gpadmode = true
		}
		
		if av != 0 {
			mousey += av * 8
			gpadmode = true
		}
		
		mousex = clamp(mousex, width / 2, width)
		mousey = clamp(mousey, 36, height - 36)
		
		if gamepad_button_check_pressed(0, gp_face1)
			press = 1
	}
	else gpadmode = false
	
	if gamepad_button_check_pressed(0, gp_face4) {
		if !loadout {
			mousex = width - width / 4
			mousey = height / 2
		}
		
		press = true
		
		gpadmode = true
	}
}
else {
	if global.desktop or mouse_check_button(mb_left) {
		mousex = device_mouse_x_to_gui(0)
		mousey = device_mouse_y_to_gui(0)
	}
	
	press = mouse_ui_clicked()
}

var mx = mousex,
	my = mousey

var any = false,
	button_size = 24

if is_gamepad()
	button_size = 14

if canloadout {
    if !weekly {
        if (race < 13 or race > 15) {
			var _x = width + yoff * 2,
				_y = height - 32
			
			if UberCont.opt_gamepad {
				draw_gamepad_button(gp_face4, true, _x - 16, _y - 20)
			}
            else draw_sprite(sprLoadoutArrow, loadout, _x, _y)
        }
		
        loadout_skin = save_get_value("cskin", string(race), 0)
        loadout_wep = save_get_value("cswep", string(race), 0)
		
        if UberCont.daily_run
			loadout_wep = 0
		
        if !instance_exists(CoopController) && !UberCont.daily_run
			loadout_crown = save_get_value("ccrown", string(race), 1)
		
		var pointed_a = point_in_circle(mx, my, width - 152, height / 2 - 32, button_size),
			pointed_b = point_in_circle(mx, my, width - 152, height / 2, button_size),
			pointed_loadout = point_in_rectangle(mx, my, width - 32, height - 64, width, height - 32),
			pointed_swep = point_in_circle(mx, my, width - 96, height - 48, button_size),
			pointed_cwep = point_in_circle(mx, my, width - 48, height - 48, button_size)
		
		if UberCont.cwep[race] == race_swep[race]
			pointed_cwep = false
		
		if (race < 13 && race > 15) && race_skin[race]
			pointed_b = false
		
		if pointed_a or pointed_b or pointed_loadout or pointed_swep or pointed_cwep
			any = true
		
        if press && !UberCont.daily_run && (race < 13 or race > 15) {
			if pointed_loadout or gamepad_button_check_pressed(0, gp_face4) {
                loadout = !loadout

                if loadout {
                    snd_play(sndMenuLoadout)
                }
				else {
                    snd_play(sndClickBack)
                }
			}

            if loadout {
				var w = inst.cwep
				
				if loadout_wep {
	                if pointed_swep {
	                    inst.cwep = UberCont.race_swep[race]
						
	                    loadout_wep = 0
	                    snd_play(wep_swap[inst.cwep])
	                    save_set_value("cswep", string(race), loadout_wep)
	                }
				}
				else if pointed_cwep {
                    inst.cwep = UberCont.cwep[race]

                    loadout_wep = 1
                    snd_play(sndGoldWeaponSelect)
                    save_set_value("cswep", string(race), loadout_wep)
                }
				
				if inst.cwep != w && instance_exists(CoopController) {
					net_add_data("other", "playerinstance", struct_clone(inst))
					inst.cwep = w
				}

                var _skin = inst.skin
				
                if pointed_a && _skin {
                    _skin = 0
                    snd_play(sndMenuASkin)
                    save_set_value("cskin", string(race), _skin)
                }
				else if pointed_b && !_skin {
                    if race_skin[race] {
                        _skin = 1
                        
                        snd_play(sndMenuBSkin)
                        save_set_value("cskin", string(race), _skin)
                    }
					else {
                        alarm[11] = 90
                        hint = skin_lock[race]
                    }
                }
				
				if inst.skin != _skin {
					inst.skin = _skin
					loadout_skin = _skin
					
					if instance_exists(CoopController) {
						net_add_data("other", "playerinstance", struct_clone(inst))
						
						// hide until event is handled
						port_x = -width
					}
					else port_x = 150
				}
            }
        }
    }

    var cwep = inst.cwep,
        no_art = 0

    if UberCont.daily_run && !weekly
        cwep = race_swep[race]
	
	var spr_load1, spr_load2;

    spr_load1 = wep_lout[@race_swep[race]]

    if weekly or !sprite_exists(spr_load1) {
        spr_load1 = wep_sprt[cwep]
        no_art = 1
    }

    spr_load2 = wep_lout[@ UberCont.cwep[race]]

    if !sprite_exists(spr_load1)
		spr_load1 = wep_sprt[race_swep[race]]
	
    if !sprite_exists(spr_load2)
		spr_load2 = wep_sprt[UberCont.cwep[race]]

    if loadout_frame >= 2 && !weekly && loadout {
        draw_sprite_ext(spr_load1, 0, width - 96, height - 60, 1, 1, 0, loadout_wep ? c_gray : c_white, 1)

        if race_swep[race] != UberCont.cwep[race]
			draw_sprite_ext(spr_load2, 0, width - 48, height - 60, 1, 1, 0, loadout_wep ? c_white : c_gray, 1)

        draw_sprite_ext(sprLoadoutCharIcon, race, width - 152, height / 2 - 32, 1, 1, 0, loadout_skin ? c_gray : c_white, 1)

        if race_skin[race] {
            draw_sprite_ext(sprLoadoutSkin, race, width - 152, height / 2, 1, 1, 0,
            qm(loadout_skin, c_white, c_gray), 1)
        }
		else draw_sprite_ext(sprLoadoutSkinLocked, race, width - 152, height / 2, 1, 1, 0, c_gray, 1)

        var dy = 0
        var dx = 96

        for (i = 0; i <= crownmax; i++) {
            if dx <= 0 or i == 2 {
                dy += 32
                dx = 128
            }
			
			if i > 0 {
				var pointed = point_in_circle(mx, my, width - dx + 8, height / 2 - 86 + dy, button_size * 0.75)
				
				if pointed
					any = true
				
	            if press && pointed {
					press = 0
					
	                if race_crown[race, i] {
						if !net_add_data("other", "crown", i) {
		                    loadout_crown = i
							
		                    snd_play(sndMenuCrown)
							
		                    save_set_value("ccrown", string(race), i)
						}
	                }
					else {
	                    alarm[11] = 45
	                    hint = "locked"
	                }
	            }
				
                draw_sprite_ext(race_crown[race, i] ? sprLoadoutCrown : sprLoadoutCrownLocked, i, width - dx + 8, height / 2 - 86 + dy, 1, 1, 0, loadout_crown == i ? c_white : c_gray, 1)
			}

            dx -= 32
        }
    }
	else {
		var _x = yoff * 2 - 48
		
        if loadout_wep {
            draw_sprite_ext(spr_load2, 0, width + _x, height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
        }
		else {
            if race == 7 && spr_load1 == sprRevolverLoadout {
                draw_sprite_ext(spr_load1, 0, width + _x + 24, height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
            }
			
            draw_sprite_ext(spr_load1, 0, width + _x, height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
        }

        if loadout_crown > 1 {
            draw_sprite(sprLoadoutCrown, loadout_crown, yoff * 2 + width - 56, height - 76)
        }
    }
}

if gpadmode {
	var crosshair = UberCont.opt_crosshair
	
	if crosshair == 9
		crosshair = 0
	
	draw_sprite_ext(sprCrosshairBig, crosshair, mousex, mousey, 1, 1, 0, c_white, any ? 1 : 0.5)
	
	if gpadpointed != any && any
		snd_play(sndHover)
	
	gpadpointed = any
	
	UberCont.show_crosshair = false
}
else {
	UberCont.show_crosshair = true
}