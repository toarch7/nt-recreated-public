function scrDrawHUD(plr = noone) {
    if !UberCont.opt_hud && room == romGame
        exit

    if plr == noone {
        with Player
        if index == global.index {
            plr = id
        }
    }

    if !plr exit

    var cont = GameCont

    if instance_exists(MakeGame)
		cont = MakeGame.cont

    var ammo = plr.ammo,
		race = plr.race,
		wep = plr.wep,
		bwep = plr.bwep,
		ultra = plr.ultra,
		hp = plr.hp,
		max_hp = plr.max_hp,
		wave = plr.wave

    if instance_exists(CoopController) {
        ultra = 0
    }

    draw_set_halign(fa_center)
    draw_set_valign(fa_top)

    var spr;

    if is_struct(plr) or instance_exists(plr) {
        draw_sprite(sprHealthBar, 2, 20, 4)

        if !plr.bleed {
            draw_sprite_ext(sprHealthFill, 2, 22, 7, max(0, 84 * (plr.lsthealth / max_hp)), 1, 0, UberCont.opt_healthcol, 1)
            draw_sprite_ext(sprHealthFill, 1, 22, 7, max(0, 84 * (hp / max_hp)), 1, 0, UberCont.opt_healthcol, 1)
            if race == 12 {
                if ultra == 1 {
                    draw_sprite(sprRogueAmmoHUDUltra, plr.rogue_ammo, 110, 11)
                } else draw_sprite(sprRogueAmmoHUD, plr.rogue_ammo, 106, 11)
            }

            if !is_struct(plr) {
                if ((plr.sprite_index = plr.spr_hurt and plr.image_index < 1 and !instance_exists(Portal)) or plr.lsthealth < hp) and !instance_exists(GenCont) and !instance_exists(LevCont)
                draw_sprite_ext(sprHealthFill, 0, 22, 7, max(0, 84 * (hp / max_hp)), 1, 0, c_white, 1)

                draw_set_halign(fa_left)

                draw_set_halign(fa_center)
                if (!((plr.sprite_index = plr.spr_hurt and plr.image_index < 1 and !instance_exists(Portal)) or plr.lsthealth < hp) or sin(wave) > 0) or instance_exists(GenCont) or instance_exists(LevCont) {
                    draw_set_color(c_black)
                    draw_text(23 + 44, 8, (string(hp) + "/" + string(max_hp)))
                    draw_text(23 + 45, 8, (string(hp) + "/" + string(max_hp)))
                    draw_text(23 + 45, 7, (string(hp) + "/" + string(max_hp)))
                    draw_set_color(c_white)
                    draw_text(23 + 44, 7, (string(hp) + "/" + string(max_hp)))
                }
            } else draw_text_shadow(23 + 44, 7, string(hp) + "/" + string(max_hp))
        }
		else {
            draw_sprite_ext(sprBleedHUD, 2, 22, 7, 84 - max(0, 84 * (plr.bleed / 150)), 1, 0, c_gray, 1)
            draw_set_halign(fa_center)

            draw_set_color(c_black)
            draw_text(23 + 44, 8, (string(hp) + "/" + string(max_hp)))
            draw_text(23 + 45, 8, (string(hp) + "/" + string(max_hp)))
            draw_text(23 + 45, 7, (string(hp) + "/" + string(max_hp)))
            draw_set_color(c_white)
            draw_text(23 + 44, 7, (string(hp) + "/" + string(max_hp)))
        }

        if bwep != 0 {
            spr = wep_sprt[bwep]
            wid = 16
            if wep_type[bwep] = 0 wid = 32 col = c_dkgray
            if race = 7 col = c_white

            if plr.bcurse gpu_set_fog(1, $8b448c, 0, 0)
            else if string_copy(wep_name[bwep], 0, 4) == "GOLD"
            gpu_set_fog(1, c_gold, 0, 0)
            else if string_copy(wep_name[bwep], 0, 5) == "ULTRA"
            gpu_set_fog(1, c_ultra, 0, 0)

            if round(cont.area / 2) == cont.area / 2 or col == c_white or plr.bcurse or string_copy(wep_name[bwep], 0, 4) == "GOLD"
            or string_copy(wep_name[bwep], 0, 5) == "ULTRA"
            or instance_exists(GenCont) or instance_exists(LevCont) or room == romInit {
                draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 67, 16, 1, 1, col, 1)
                draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 69, 16, 1, 1, col, 1)
                draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 68, 15, 1, 1, col, 1)
                draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 68, 17, 1, 1, col, 1)
            }

            gpu_set_fog(0, c_white, 0, 0)

            draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 68, 16, 1, 1, c_black, 1)
            draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, max(0, wid * min(wep_load[bwep], plr.breload / wep_load[bwep])), 14, 68, 16, 1, 1, c_white, 0.2)

            if wep_type[bwep] != 0 {
                draw_set_halign(fa_left)
                draw_set_color(c_black)

                draw_text(86, 22, (string(ammo[wep_type[bwep]])))
                draw_text(87, 22, (string(ammo[wep_type[bwep]])))
                draw_text(87, 21, (string(ammo[wep_type[bwep]])))

                if race = 7 or wep_type[bwep] = wep_type[bwep] draw_set_color(c_white)
                else draw_set_color(c_silver)

                if ammo[wep_type[bwep]] <= typ_ammo[wep_type[bwep]] {
                    if race = 7 or wep_type[bwep] = wep_type[bwep] draw_set_color(c_red)
                    else draw_set_color(c_gray)
                }
                if ammo[wep_type[bwep]] = 0 draw_set_color(c_dkgray) draw_text(86, 21, (string(ammo[wep_type[bwep]])))
            }
        }

        //PRIMARY WEAPON
        spr = wep_sprt[wep]
        var wid = 16
        if wep_type[wep] = 0 wid = 32

        if plr.curse gpu_set_fog(1, $8b448c, 0, 0)
        else if string_copy(wep_name[wep], 0, 4) == "GOLD"
        gpu_set_fog(1, c_gold, 0, 0)
        else if string_copy(wep_name[wep], 0, 5) == "ULTRA"
        gpu_set_fog(1, c_ultra, 0, 0)

        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 25, 16, 1, 1, c_white, 1)
        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 23, 16, 1, 1, c_white, 1)
        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 24, 17, 1, 1, c_white, 1)
        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 24, 15, 1, 1, c_white, 1)

        gpu_set_fog(0, c_white, 0, 0)

        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, wid, 14, 24, 16, 1, 1, c_black, 1)
        draw_sprite_part_ext(spr, 1, sprite_get_xoffset(spr), sprite_get_yoffset(spr) - 8, max(0, wid * min(wep_load[wep], plr.reload / wep_load[wep])), 14, 24, 16, 1, 1, c_white, 0.2)

        if wep_type[wep] != 0 {
            draw_set_halign(fa_left)
            draw_set_color(c_black)
            draw_text(42, 22, (string(ammo[wep_type[wep]])))
            draw_text(43, 22, (string(ammo[wep_type[wep]])))
            draw_text(43, 21, (string(ammo[wep_type[wep]])))

            draw_set_color(c_white)
            if ammo[wep_type[wep]] <= typ_ammo[wep_type[wep]] draw_set_color(c_red)
            if ammo[wep_type[wep]] = 0 draw_set_color(c_dkgray) draw_text(42, 21, (string(ammo[wep_type[wep]])))
        }

        //EXPERIENCE BAR
        draw_set_halign(fa_center)
        if cont.skillpoints > 0 or cont.ultrapoints draw_sprite(sprExpBarLevel, 0, 4, 4) draw_sprite(sprExpBar, (cont.rad / cont.max_rad) * 16, 4, 4)
        if cont.level < 10 {
            draw_set_color(c_black)
            draw_text(11, 17 - string_height(("A")) / 2, (string(cont.level)))
            draw_text(12, 17 - string_height(("A")) / 2, (string(cont.level)))
            draw_text(12, 16 - string_height(("A")) / 2, (string(cont.level)))
            draw_set_color(c_white)
            draw_text(11, 16 - string_height(("A")) / 2, (string(cont.level)))
        } else draw_sprite(sprUltraLevel, 0, 11, 16)

        var img;

        //AMMO ICONS
        img = 0
        if wep_type[wep] = 1 img = 1
        if wep_type[wep] = 1 or (race = 7 and wep_type[wep] = 1) img = 2
        draw_sprite(sprBulletIconBG, img, 2, 32)
        draw_sprite(sprBulletIcon, 7 - ceil((ammo[1] / typ_amax[1]) * 7), 2, 32)

        img = 0
        if wep_type[wep] = 2 img = 1
        if wep_type[wep] = 2 or (race = 7 and wep_type[wep] = 2) img = 2
        draw_sprite(sprShotIconBG, img, 12, 32)
        draw_sprite(sprShotIcon, 7 - ceil((ammo[2] / typ_amax[2]) * 7), 12, 32)

        img = 0
        if wep_type[wep] = 3 img = 1
        if wep_type[wep] = 3 or (race = 7 and wep_type[wep] = 3) img = 2
        draw_sprite(sprBoltIconBG, img, 22, 32)
        draw_sprite(sprBoltIcon, 7 - ceil((ammo[3] / typ_amax[3]) * 7), 22, 32)

        img = 0
        if wep_type[wep] = 4 img = 1
        if wep_type[wep] = 4 or (race = 7 and wep_type[wep] = 4) img = 2
        draw_sprite(sprExploIconBG, img, 32, 32)
        draw_sprite(sprExploIcon, 7 - ceil((ammo[4] / typ_amax[4]) * 7), 32, 32)

        img = 0
        if wep_type[wep] = 5 img = 1
        if wep_type[wep] = 5 or (race = 7 and wep_type[wep] = 5) img = 2
        draw_sprite(sprEnergyIconBG, img, 42, 32)
        draw_sprite(sprEnergyIcon, 7 - ceil((ammo[5] / typ_amax[5]) * 7), 42, 32)

        if UberCont.daily_run {
            draw_sprite(sprDailyIcon, UberCont.weekly_run, 56, 32)
        }

        //LOW AMMO WARNING
        if ammo[wep_type[wep]] <= typ_ammo[wep_type[wep]] && sin(wave) > 0 && plr.drawempty > 0 && wep_type[wep] != 0 {
            if plr.drawempty = 10 and ammo[wep_type[wep]] > typ_ammo[wep_type[wep]] - wep_cost[wep] snd_play(plr.snd_lowa)
            plr.drawempty--

            txt = loc_sfmt("LOW %", loc(typ_name[wep_type[wep]]))

            if ammo[wep_type[wep]] < wep_cost[wep] {
                if ammo[wep_type[wep]] > 0 {
                    txt = loc_sfmt("NOT ENOUGH %", loc(typ_name[wep_type[wep]]))
                } else txt = loc("EMPTY")
            }

            draw_set_halign(fa_left)
            draw_set_color(c_black)
            draw_text(55, 34, (string(txt)))
            draw_text(55, 35, (string(txt)))
            draw_text(54, 35, (string(txt)))
            draw_set_color(c_red)
            draw_text(54, 34, (string(txt)))
        }

        draw_set_halign(fa_left)

        if hp <= 4 and hp != max_hp and sin(wave) > 0 and plr.drawlowhp > 0 {
            plr.drawlowhp--
            var txt = loc("LOW HP")

            draw_set_color(c_black)
            draw_text(111, 7, (string(txt)))
            draw_text(111, 8, (string(txt)))
            draw_text(110, 8, (string(txt)))
            draw_set_color(c_red)
            draw_text(110, 7, (string(txt)))
        }
    }
	
    if UberCont.continued_run {
        draw_set_font(fontSmall)
        draw_set_alpha(0.1)
        draw_set_color(c_white)
		
		if global.recontuations > 1 {
			draw_text(0, 45, "continued x" + string(global.recontuations))
		}
        else draw_text(0, 45, "continued")
        
		draw_set_alpha(1)
        draw_set_font(fntM1)
    }

    draw_set_halign(fa_center)
	draw_set_color(c_white)
	
    with WepPickup {
        x = round(x)
        y = round(y)

        if visible {
            if place_meeting(x, y, plr) {
				var _x = x_rel_view,
					_y = y_rel_view,
					
					off = draw_pickup_button(_x, _y),
					
					_name = loc(string(name))
				
                scrDrawTypeAmmo(type, ammo[type] / typ_amax[type], _x + off, _y - 21)
				
                draw_text_nt(_x, _y - 31, _name)
				
                if !UberCont.opt_keyboard && !UberCont.opt_gamepad {
                    with ButtonAct {
                        draw_sprite_ext(other.sprite_index, other.image_index, x, y, 2, 2, other.image_angle, c_white, 1)
                        draw_set_valign(fa_center)
                        draw_text_shadow(x, y + 36, loc("PICK UP"))
                        draw_set_valign(fa_left)

                        active = 1
                    }
                }
            }
        }
    }

    with CarVenusFixed {
        if place_meeting(x, y, plr) {
			var _x = x_rel_view,
				_y = y_rel_view,
				
				off = draw_pickup_button(_x, _y)
			
            draw_pickup_button(_x, _y)
			
			draw_text_shadow(_x + off, _y - 30, loc(name))

            with ButtonAct {
                draw_sprite(other.sprite_index, other.image_index, x, y)
                draw_text_shadow(x, y + 36, loc("CAR"))

                active = 1
            }
        }
    }

    with JungleFlower {
        if place_meeting(x, y, plr) {
            var _x = x_rel_view,
				_y = y_rel_view,
				
				off = draw_pickup_button(_x, _y)
			
            draw_pickup_button(_x, _y)
			
			draw_text_shadow(_x + off, _y - 30, loc(name))

            with ButtonAct {
                draw_sprite(other.sprite_index, other.image_index, x, y)
                draw_text_shadow(x, y + 36, loc("FEED"))

                active = 1
            }
        }
    }

    with Van
    if can_hq && drawspr == sprVanDeactivate {
        if place_meeting(x, y, plr) {
            var _x = x_rel_view,
				_y = y_rel_view,
				
				off = draw_pickup_button(_x, _y)
			
            draw_pickup_button(_x, _y)
			
			draw_text_shadow(_x + off, _y - 30, loc(name))

            with ButtonAct {
                draw_sprite(other.sprite_index, other.image_index, x, y)
                draw_text_shadow(x, y + 36, loc("VAN"))

                active = 1

                if alpha < 1.1 {
                    alpha += 0.4
                }
            }
        }
    }

    draw_set_color(c_white)
}

function scrDrawTypeAmmo(type, amount, x, y) {
	var s;
	
	switch type {
		default:
			exit
		
		case 1: s = "Bullet" break
		case 2: s = "Shot" break
		case 3: s = "Bolt" break
		case 4: s = "Explo" break
		case 5: s = "Energy" break
	}
	
	var spr = asset_get_index("spr" + s + "Icon"),
		bg = asset_get_index("spr" + s + "IconBG")
	
    draw_sprite(bg, 2, x, y)
	draw_sprite(spr, 7 - ceil(amount * 7), x, y)
}