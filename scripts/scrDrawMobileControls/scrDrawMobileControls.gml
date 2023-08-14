function scrDrawMobileControls(plr = noone, scale = UberCont.opt_controls_scale) {
    var width = 1

    scale = min(1 + scale, 1.5)
    var m = (0.5 + scale) / 2

    draw_set_color(c_white)

    with JoystickMove {
        var dir = KeyCont.dir_move[global.index]
        var dis = rad * KeyCont.moving[global.index]

        var xx = lengthdir_x(dis, dir)
        var yy = lengthdir_y(dis, dir)

        if UberCont.opt_simplify {
            draw_circle_width(x, y, rad * m, width)
	
            if dis
				draw_set_color(c_gray)

            draw_circle(x + xx, y + yy, rad / 3 * m, 0)
            draw_set_color(c_white)
        } else {
            draw_sprite_ext(sprMobileControlJoystick, 0, x, y, scale, scale, 0, c_white, 1)
            draw_sprite_ext(sprMobileControlJoystick, 1, x + xx, y + yy, scale, scale, 0, c_white, 1)
        }
    }

    with JoystickAttack {
        var dir = KeyCont.dir_fire[global.index]
        var dis = self.dis

        var xx = lengthdir_x(dis, dir)
        var yy = lengthdir_y(dis, dir)

        if UberCont.opt_simplify {
            draw_circle_width(x, y, rad * m, width)

            if dis draw_set_color(c_gray)

            draw_circle(x + xx, y + yy, rad / 3 * m, 0)
            draw_set_color(c_white)
        }
		else {
            var col = UberCont.opt_cursorcol

            if col == c_white {
                col = make_color_rgb(125, 253, 13)
            }

            var c = UberCont.opt_crosshair

            draw_sprite_ext(sprMobileControlJoystick, 0, x, y, scale, scale, 0, c_white, 1)
            draw_sprite_ext(sprCrosshairBig, c, x + xx, y + yy, scale / 2, scale / 2, 0, col, 1)
        }
    }

    var crystaltb = instance_exists(plr) && plr.race == 2 && skill_get(5)

    with ButtonActive {
        if !crystaltb {
            var d = self[$ "do_thing"],
                c = c_white

            if d == -1 c = c_yellow
            else if d == 2 c = c_lime

            draw_sprite_ext(
            sprMobileControlAbility, 0,
            x, y, scale * 0.75, scale * 0.75,
            0, (KeyCont.activeforever[global.index] ? c_lime : merge_color((index != -1 ? c_gray : c_white), c, 0.5)), 1)

            if instance_exists(plr) && plr.race == 12 {
                draw_set_halign(fa_center)
                draw_set_valign(fa_center)
                draw_text_shadow(x, y, "SCREEN#SWIPE")
                draw_set_halign(fa_left)
                draw_set_valign(fa_top)
            }
        } else draw_sprite_ext(sprSkillIconHUD, 5, x, y, scale, scale, 0, c_white, 0.5)
    }


    with ButtonAct {
        if !plr alpha = 1

        var d = self[$ "do_thing"],
            c = (d == 1 ? c_lime : (d == -1 ? c_yellow : (d == 2 ? c_gray : c_white)))

            if UberCont.opt_simplify {
                draw_set_color(c)
                draw_set_alpha(alpha)
                draw_circle_width(x, y, rad * m, width)
                draw_set_alpha(1)
                draw_set_color(c_white)
            } else {
                draw_sprite_ext(sprMobileControlCorners, 0, x, y, scale, scale, 0, c, alpha)
            }
    }

    with ButtonSwap {
        draw_set_alpha(0.7)

        var d = self[$ "do_thing"],
            c = (d == 1 ? c_lime : (d == -1 ? c_yellow : (d == 2 ? c_gray : c_white)))
            draw_set_color(c)

        var wep = instance_exists(plr) ? plr.wep : 1
        var bwep = instance_exists(plr) ? plr.bwep : 3
        var reload = instance_exists(plr) ? plr.reload : 4

        if !UberCont.opt_simplify {
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
        var l = save_get_val("etc", "language", "null")
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
                draw_circle_width(x, y, rad * (UberCont.opt_controls_scale * 1.5 + 0.5), s)
            }

            self[$ "fancyrad"] = s
        }
    }
}