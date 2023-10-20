function scrDrawMobileControls(plr = noone, scale = UberCont.opt_controls_scale) {
	if UberCont.quit_pause or UberCont.want_pause
		exit
	
    var width = 1,
		hiddensticks = UberCont.opt_hiddensticks,
		simplify = UberCont.opt_simplify,
		aimbot = UberCont.opt_aimbot

    scale = min(1 + scale, 1.5)
    var m = (0.5 + scale) / 2

    draw_set_color(c_white)

    with JoystickMove {
        var dir = KeyCont.dir_move[global.index]
        var dis = rad * KeyCont.moving[global.index]

        var xx = lengthdir_x(dis, dir)
        var yy = lengthdir_y(dis, dir)

        if simplify {
			draw_set_alpha(image_alpha)
			
			draw_circle_width(x, y, rad * m, width)
	
            if dis
				draw_set_color(c_gray)

            draw_circle(x + xx, y + yy, rad / 3 * m, 0)
            draw_set_color(c_white)
			
			draw_set_alpha(1)
        }
		else {
			draw_sprite_ext(sprMobileControlJoystick, 0, x, y, scale, scale, 0, c_white, image_alpha)
            draw_sprite_ext(sprMobileControlJoystick, 1, x + xx, y + yy, scale, scale, 0, c_white, image_alpha)
        }
    }

    with JoystickAttack {
        var dir = KeyCont.dir_fire[global.index],
			dis = self.dis
		
        var xx = lengthdir_x(dis, dir),
			yy = lengthdir_y(dis, dir),
			a = image_alpha,
			ang = 0,
			draw_out = false
		
		var wepstick = instance_is(self, WepstickAttack),
			wepstick_scale = 0.8
		
		if aimbot {
			ang = 45
			
			xx = 0
			yy = 0
		}
		
        if simplify {
			draw_set_alpha(a)
			
            draw_circle_width(x, y, rad * m, width)

            if dis
				draw_set_color(c_gray)
			
			if ang > 0 {
				draw_circle_width(x + xx, y + yy, rad / 4 * m, width)
			}
            else draw_circle(x + xx, y + yy, rad / 3 * m, 0)
			
            draw_set_color(c_white)
			draw_set_alpha(1)
        }
		else {
            var col = 0x0dfd98,
				crosshair = UberCont.opt_crosshair,
				splitfire = UberCont.opt_splitfire
			
			if !splitfire && UberCont.opt_cursorcol != c_white
				col = UberCont.opt_cursorcol
			
			var _s = scale
			
			if wepstick
				_s *= wepstick_scale
			
			draw_sprite_ext(sprMobileControlJoystick, 0, x, y, _s, _s, ang, c_white, a)
			
			draw_sprite_ext(sprCrosshairBig, crosshair, x + xx, y + yy, _s / 2, _s / 2, ang, col, a)
			
			if (splitfire && !wepstick) or (index != -1 && !(wepstick or aimbot ) && (!splitfire && (dis / rad) < ATTACK_BUTTON_DEADZONE))
				draw_sprite_ext(sprMobileControlJoystick, 2, x, y, _s, _s, ang, c_gray, a)
		}
		
		if wepstick {
			var col = active ? make_color_hsv(65, 242, 252) : c_gray,
				_s = scale * wepstick_scale
			
			if index != -1 && (dis / rad) < ATTACK_BUTTON_DEADZONE
				col = merge_color(col, c_gray, 0.5)
			
			if !simplify
				draw_sprite_ext(sprMobileControlJoystick, 2, x, y, _s, _s, ang, col, a)
			
			var current = instance_exists(plr) ? wep_spr : (wep_sprt[primary ? 1 : 3])
			
			if current != mskNone {
				var col = active ? c_white : c_gray,
					_s = (scale + 0.5) * 0.67
				
				draw_sprite_ext(current, 0, x + xx * 0.37 + 8, y + yy * 0.37 + 12, _s, _s, 60, col, a)
			}
		}
    }

    var crystaltb = instance_exists(plr) && plr.race == 2 && skill_get(5)

    with ButtonActive {
        if !crystaltb {
            var d = self[$ "do_thing"],
                c = c_white,
				forever = KeyCont.activeforever[global.index]
			
			if forever {
				c = c_lime
			}
			else {
				if d == -1 {
					c = c_yellow
				}
	            else if d == 2 {
					c = c_ultra
				}
				
				if index != -1
					c = merge_color(c, c_gray, 0.5)
			}
			
            draw_sprite_ext(sprMobileControlAbility, 0, x, y, scale * 0.75, scale * 0.75, 0, c, 1)

            if instance_exists(plr) && plr.race == 12 && player_pref(plr, "rogue") {
                draw_set_halign(fa_center)
                draw_set_valign(fa_center)
				
                draw_text_shadow(x, y, "SCREEN#SWIPE")
                
				draw_set_halign(fa_left)
                draw_set_valign(fa_top)
            }
        }
		else draw_sprite_ext(sprSkillIconHUD, 5, x, y, scale, scale, 0, c_white, 0.5)
    }


    with ButtonAct {
        if !plr alpha = 1

        var d = self[$ "do_thing"],
            c = (d == 1 ? c_lime : (d == -1 ? c_yellow : (d == 2 ? c_gray : c_white)))
		
        if simplify {
            draw_set_color(c)
            draw_set_alpha(alpha)
            draw_circle_width(x, y, rad * m, width)
            draw_set_alpha(1)
            draw_set_color(c_white)
        }
		else {
            draw_sprite_ext(sprMobileControlCorners, 0, x, y, scale, scale, 0, c, alpha)
        }
    }
	
	with ButtonAttack {
        var _s = scale / 2,
			col = UberCont.opt_cursorcol
		
		if simplify {
            draw_set_color(c_white)
            draw_set_alpha(1)
			
            draw_circle_width(x, y, rad / 2 * m, width)
			
            draw_set_alpha(1)
            draw_set_color(c_white)
			
			col = c_white
        }
		else {
            draw_sprite_ext(sprMobileControlCorners, 0, x, y, scale, scale, 0, c_white, 1)
        }
		
	    if col == c_white
	        col = make_color_rgb(125, 253, 13)
		
        draw_sprite_ext(sprCrosshairBig, UberCont.opt_crosshair, x, y + _s, _s, _s, 0, c_black, 1)
        draw_sprite_ext(sprCrosshairBig, UberCont.opt_crosshair, x, y, _s, _s, 0, col, 1)
    }

    with ButtonSwap {
        draw_set_alpha(0.7)

        var d = self[$ "do_thing"],
            c = (d == 1 ? c_lime : (d == -1 ? c_yellow : (d == 2 ? c_gray : c_white)))
            draw_set_color(c)

        var wep = instance_exists(plr) ? plr.wep : 1
        var bwep = instance_exists(plr) ? plr.bwep : 3
        var reload = instance_exists(plr) ? plr.reload : 4

        if !simplify {
            draw_circle_part(x, y, rad * m, width, 1 - reload / wep_load[wep])
        } else draw_circle_width(x, y, rad * m, width)

        draw_set_color(c_white)
        draw_set_alpha(1)

        if bwep {
            var s = wep_sprt[bwep]
            var offx = round(sprite_get_width(s) / 2) - sprite_get_xoffset(s)
            var offy = round(sprite_get_height(s) / 2) - sprite_get_yoffset(s)
            draw_sprite_ext(s, 0, x - offx, y - offy, scale + 0.5, scale + 0.5, - rot + 30, c_gray, 1)
        }

        if wep {
            s = wep_sprt[wep]
            offx = round(sprite_get_width(s) / 2) - sprite_get_xoffset(s)
            offy = round(sprite_get_height(s) / 2) - sprite_get_yoffset(s)
            draw_sprite_ext(s, 0, x - offx, y - offy, scale + 0.5, scale + 0.5, rot, c_white, 1)
        }
    }

    if UberCont.opt_volumecontrol {
        var l = save_get_value("etc", "language", "null")
        var s = sprMobileVolumeControl

        if l == "ru"
        or l == "ua" {
            s = sprMobileVolumeControlRU
        }

        with MobileUI {
            if self[$ "do_thing"] != undefined {
                var o = rad / 2 + 4

                if object_index == ButtonAct
                continue

                if object_index == ButtonSwap && instance_exists(plr) && !plr.bwep {
                    draw_sprite_ext(s, 0, x + o, y + o, 1, 1, 0, c_white, 0.33)
                } else draw_sprite(s, (object_index == ButtonActive), x + o, y + o)
            }
        }
    }

    if instance_exists(MenuOptions) && MenuOptions.editing_mode {
        with MobileUI {
            var s = self[$ "fancyrad"] ?? 0

            if index != -1 {
                s = lerp(s, 1, 0.1)
            }
			else s = lerp(s, 0, 0.2)

            if s > 0 {
                draw_circle_width(x, y, get_touch_radius(rad), s)
            }

            self[$ "fancyrad"] = s
        }
    }
}