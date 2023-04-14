scrDrawSpiral()

var prt, inst = playerinstance_get(global.index);

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var _w = widescreen

race = inst.race
loadout_wep = 0

draw_text(view_xview + 96, view_yview + 100, string(race) + " " + string(inst))

if instance_exists(DailyList) {
    if dailylistfavor < 48 {
        dailylistfavor += 16
    }
}
else if dailylistfavor {
    dailylistfavor -= 24

    if dailylistfavor < 0 {
        dailylistfavor = 0
    }
}

var yoff = dailylistfavor


if global.coop {
    var picks = struct_keys(UberCont.playerinstances),
        n = 0

    for (var i = array_length(picks) - 1; i >= 0; i--) {
        var _inst = playerinstance_get(picks[i])

        if _inst.index == global.index or _inst.race == 0 {
            continue
        }

        prt = _inst.skin ? sprBigPortraitSkin : sprBigPortrait
        draw_sprite_ext(prt, _inst.race, view_xview + ports_x[i] + view_width + 16 - n * 24, view_yview + view_height - 20, - 1, 1, 0, c_gray, 1)
        ports_x[i] = lerp(ports_x[i], 0, 0.8)

        n++
    }
}

prt = sprBigPortrait

if inst.skin {
    prt = sprBigPortraitSkin
}

view_yview++draw_sprite(prt, race, view_xview - yoff * 4 - port_x - 24, view_yview + view_height - 38)
draw_sprite(sprCharSplat, splat_index, view_xview - yoff * 1.6, view_yview + view_height - 36)

draw_sprite_ext(sprBigNames, race, view_xview - yoff * 4 + 1, view_yview + view_height - 60 + ((race == 0) * 26), 1, 1, 0, c_black, 1)
draw_sprite_ext(sprBigNames, race, view_xview - yoff * 4 + 1, view_yview + 2 + view_height - 60 + ((race == 0) * 26), 1, 1, 0, c_black, 1)
draw_sprite_ext(sprBigNames, race, view_xview - yoff * 4, view_yview + 2 + view_height - 60 + ((race == 0) * 26), 1, 1, 0, c_black, 1)

draw_sprite(sprBigNames, race, view_xview - yoff * 4, view_yview + view_height - 60 + ((race == 0) * 26))

view_yview--

draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + widescreen, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - widescreen, 0)
draw_set_color(c_white)
draw_text_nt(view_xview - yoff * 4 + 6, view_yview + view_height - 56, string_replace(loc(race_pass[race]) + "#" + loc(race_acti[race]), ", ", "#"))

if port_x > 0 {
	port_x = lerp(port_x, 0, 0.8)
}

if splat_index < 3 splat_index++

with CharSelect {
    x = view_xview + 16 + 20 * pos
    y = view_yview + view_height - 32
}

with GoButton {
    x = view_xview + view_width - 24 + yoff * 4
    y = view_yview + view_height - 12

    draw_self()
}

draw_sprite(sprLoadoutSplat, splat_index, view_xview + yoff + view_width, view_yview + view_height - 31)

var canloadout = race != 0 // && !(race >= 13 && race <= 15)

if loadout && canloadout {
    if loadout_frame < 4 {
        loadout_frame++
    }

    draw_set_color(c_black)
    draw_rectangle(view_xview + view_width, view_yview + view_height - 32, view_xview + UberCont.max_view_width, view_yview + 32, 0)
    draw_set_color(c_white)
} else if loadout_frame loadout_frame--

if loadout_frame > 0 {
    draw_sprite(sprLoadout, loadout_frame, view_xview + view_width, view_yview + view_height - 36)
}

if canloadout {
    if !weekly {
        if (race < 13 or race > 15) {
            draw_sprite(sprLoadoutArrow, loadout, view_xview + view_width + yoff * 2, view_yview + view_height - 32)
        }

        loadout_skin = save_get_val("cskin", string(race), 0)
        loadout_wep = save_get_val("cswep", string(race), 0)

        if UberCont.daily_run loadout_wep = 0

        if !instance_exists(CoopController) && !UberCont.daily_run loadout_crown = save_get_val("ccrown", string(race), 1)

        if mouse_check_button_pressed(mb_left) && !UberCont.daily_run && (race < 13 or race > 15) {
            if point_in_rectangle(mx, my, view_width - 32, view_height - 64, view_width, view_height - 32) {
                loadout = !loadout

                if loadout {
                    snd_play(sndMenuLoadout)
                } else {
                    snd_play(sndClickBack)
                }
            }

            if loadout {
				var w = inst.cwep
				
                if point_in_circle(mx, my, view_width - 96, view_height - 48, 24) && loadout_wep {
                    inst.cwep = UberCont.race_swep[race]

                    loadout_wep = 0
                    snd_play(wep_swap[inst.cwep])
                    save_set_val("cswep", string(race), loadout_wep)
                }

                if UberCont.cwep[race] != race_swep[race] && !loadout_wep && point_in_circle(mx, my, view_width - 48, view_height - 48, 24) {
                    inst.cwep = UberCont.cwep[race]

                    loadout_wep = 1
                    snd_play(sndGoldWeaponSelect)
                    save_set_val("cswep", string(race), loadout_wep)
                }
				
				if inst.cwep != w && instance_exists(CoopController) {
					net_add_data("other", "playerinstance", struct_clone(inst))
					inst.cwep = w
				}

                var _skin = inst.skin
				
                if point_in_circle(mx, my, view_width - 152, view_height / 2 - 32, 24) && _skin {
                    _skin = 0
                    snd_play(sndMenuASkin)
                    save_set_val("cskin", string(race), _skin)
                }
				else if point_in_circle(mx, my, view_width - 152, view_height / 2, 24) && !_skin {
                    if race_skin[race] {
                        _skin = 1
                        
                        snd_play(sndMenuBSkin)
                        save_set_val("cskin", string(race), _skin)
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
						port_x = -view_width
					}
					else port_x = 150
				}
            }
        }
    }

    var cwep = inst.cwep,
        no_art = 0

    if UberCont.daily_run && !weekly {
        cwep = race_swep[race]
    }

    spr_load1 = wep_lout[@race_swep[race]]

    if weekly or!sprite_exists(spr_load1) {
        spr_load1 = wep_sprt[cwep]
        no_art = 1
    }

    spr_load2 = wep_lout[@UberCont.cwep[race]]

    if !sprite_exists(spr_load1) spr_load1 = wep_sprt[race_swep[race]]
    if !sprite_exists(spr_load2) spr_load2 = wep_sprt[UberCont.cwep[race]]

    if loadout_frame >= 2 && !weekly && loadout {
        draw_sprite_ext(spr_load1, 0, view_xview + view_width - 96, view_yview + view_height - 60, 1, 1, 0,
        qm(loadout_wep, c_gray, c_white), 1)

        if race_swep[race] != UberCont.cwep[race] draw_sprite_ext(spr_load2, 0, view_xview + view_width - 48, view_yview + view_height - 60, 1, 1, 0,
        qm(loadout_wep, c_white, c_gray), 1)

        draw_sprite_ext(sprLoadoutCharIcon, race, view_xview + view_width - 152, view_yview + view_height / 2 - 32, 1, 1, 0,
        qm(loadout_skin, c_gray, c_white), 1)

        if race_skin[race] {
            draw_sprite_ext(sprLoadoutSkin, race, view_xview + view_width - 152, view_yview + view_height / 2, 1, 1, 0,
            qm(loadout_skin, c_white, c_gray), 1)
        } else draw_sprite_ext(sprLoadoutSkinLocked, race, view_xview + view_width - 152, view_yview + view_height / 2, 1, 1, 0, c_gray, 1)

        var dy = 0
        var dx = 96

        for (i = 0; i <= crownmax; i++) {
            if dx <= 0 or i == 2 {
                dy += 32
                dx = 128
            }

            if i > 0 && mouse_check_button_pressed(mb_left) && point_in_circle(mouse_x, mouse_y, view_xview + view_width - dx + 8, view_yview + view_height / 2 - 86 + dy, 16) {
                if race_crown[race, i] {
                    save_set_val("ccrown", string(race), i)
                    loadout_crown = i
                    snd_play(sndMenuCrown)
                } else {
                    alarm[11] = 45
                    hint = "locked"
                }
            }

            if i > 0 {
                draw_sprite_ext(race_crown[race, i] ? sprLoadoutCrown : sprLoadoutCrownLocked, i, view_xview + view_width - dx + 8, view_yview + view_height / 2 - 86 + dy, 1, 1, 0, qm(loadout_crown == i, c_white, c_gray), 1)
            }

            dx -= 32
        }
    } else {
        if loadout_wep {
            draw_sprite_ext(spr_load2, 0, view_xview + view_width + yoff * 2 - 48, view_yview + view_height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
        } else {
            if race == 7 && spr_load1 == sprRevolverLoadout {
                draw_sprite_ext(spr_load1, 0, view_xview + view_width + yoff * 2 - 48 + 24, view_yview + view_height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
            }
            draw_sprite_ext(spr_load1, 0, view_xview + view_width + yoff * 2 - 48, view_yview + view_height - 56, 1 + no_art, 1 + no_art, 30 * no_art, c_white, 1)
        }

        if loadout_crown > 1 {
            draw_sprite(sprLoadoutCrown, loadout_crown, view_xview + yoff * 2 + view_width - 56, view_yview + view_height - 76)
        }
    }
}

if instance_exists(char[race]) {
    with char[race] {
        view_xview = (lerp(view_xview, x - view_width / 2, 0.1))
        view_yview = (lerp(view_yview, y - view_height / 2, 0.1))
    }
}

with CharSelect {
	var c = c_gray,
		spr = sprCharSelectLocked
	
	if selected
		c = c_white
	
	if UberCont.cgot[num] or other.weekly {
		spr = sprCharSelect
	}
	
    draw_sprite_ext(spr, num, x, y + yoff + 16, 1, 1, 0, c, 1)
}

with CharSelect {
    if UberCont.cgot[num] && UberCont.ctot_dead[num] <= 0 && num != 0 {
        draw_sprite(sprNew, - 1, x - 6, y + yoff + 6)
    }
}

inst.race = race