wave += 1

var spr = -1

if GameCont.area == 102 {
    spr = sprFog102
} else if (GameCont.area == 2 or UberCont.halloween) {
    spr = sprFog2
}

if spr != -1 {
    var fogx = floor(view_xview / 480) * 480 + 480 - fogscroll
    var fogy = floor(view_yview / 360) * 360

    for (var xx = -1; xx <= 1; xx++) {
        for (var yy = -1; yy <= 1; yy++) {
            draw_sprite_ext(spr, 0, fogx + xx * 480, fogy + yy * 360, 1, 1, 0, c_white, FOG_ALPHA)
        }
    }

    if !UberCont.paused {
        fogscroll += 0.5

        if fogscroll >= 480 {
            fogscroll -= 480
        }
    }
}

with Player {
    if visible {
        if !UberCont.opt_keyboard or(index == 1 && UberCont.localcoop) {
            var ang = KeyCont.dir_fire[index]
            draw_sprite_ext(sprCrosshair, KeyCont.crosshair[index], x + lengthdir_x(64, ang), y + lengthdir_y(64, ang), 1, 1, 0, UberCont.opt_cursorcol, index == global.index ? 1 : 0.5)
        }

        if KeyCont.players > 1 {
            draw_sprite(sprPlayerIndicator, index, clamp(x, view_xview + 8, view_xview + view_width - 8), clamp(y - 8, view_yview + 16, view_yview + view_height - 4))
        }
    }
}

if darkness {
    if !instance_exists(GenCont) && !UberCont.paused {
        scrDarkness()
    }

    draw_set_blend_mode(bm_subtract)

    if surface_exists(dark) && !UberCont.getpauseimg {
        draw_surface_ext(dark, view_xview, view_yview, 1, 1, 0, c_white, 1)
    }

    draw_set_blend_mode(bm_normal)
}

if instance_exists(Player) with Revive {
    var _x = clamp(x, view_xview + 30, view_xview + view_width - 30)
    var _y = clamp(y - 16, view_yview + 6, view_yview + view_height - 6)

    draw_sprite(sprFaintedBar, 0, _x, _y)

    _x -= 16
    _y -= 5
    if alarm[4] {
        draw_set_color(merge_color(c_red, c_black, 0.5 + sin(GameCont.tottimer / 4) * 0.25))
        draw_rectangle(_x + 2, _y + 2, _x + 2 + alarm[4] / 300 * 28, _y + 6, 0)
    } else if alarm[5] {
        draw_set_color(c_red)
        draw_rectangle(_x + 2, _y + 2, _x + alarm[5] / 30 * 28, _y + 6, 0)
    }
    _x += 16
    _y += 5

    draw_set_color(c_white)
}

if UberCont.getpauseimg && !instance_exists(GenCont) && surface_exists(application_surface) {
    with UberCont {
        if pausespr && sprite_exists(pausespr) {
            sprite_delete(pausespr)
        }

        var srf = surface_create(view_width, view_height)
        surface_set_target(srf)
        draw_surface_ext(application_surface, 0, 0, 1 / opt_scaling, 1 / opt_scaling, 0, c_white, 1)

        if !instance_exists(NothingSpiral) with Spiral {
            draw_sprite_ext(sprite_index, - 1, x, y, image_xscale * 5, image_yscale * 5, image_angle, c_white, 1)
            draw_sprite_ext(sprite_index, - 1, x, y, image_xscale * 5, image_yscale * 5, image_angle, c_black, 0.8 - image_xscale)
        }

        draw_set_blend_mode(bm_add)
        draw_set_color(c_black)
        draw_rectangle(0, 0, view_width, view_height, 0)
        draw_set_color(c_white)
        draw_set_blend_mode(bm_normal)
        surface_reset_target()

        pausespr = sprite_create_from_surface(srf, 0, 0, view_width, view_height, 0, 0, 0, 0)

        getpauseimg = 0
    }
}

if !instance_exists(MenuGen) {
    if !instance_exists(NothingSpiral) with Spiral {
        draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale * 5, image_yscale * 5, image_angle, c_white, 1)
        draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale * 5, image_yscale * 5, image_angle, c_black, 0.8 - image_xscale)
    }

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)

    with PopupText {
        if visible {
            draw_set_color(c_white)
            draw_text_nt(median(view_xview + view_width - 10 - string_width((mytext)) / 2, view_xview + 10 + string_width((mytext)) / 2, x), median(view_yview + view_height - 30, view_yview + 20, y), (string(mytext)))
        }
    }

    with LevelUp {
        draw_sprite(sprite_index, - 1, x, y)
    }

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
}

with WepSwap draw_self()

if instance_exists(Portal) {
    with Portal {
        if !(x > view_xview && y > view_yview && x < view_xview + view_width && y < view_yview + view_height) {
            draw_sprite(sprPortalindicator, 0, clamp(x, view_xview + 10, view_xview + view_width - 10), clamp(y, view_yview + 10, view_yview + view_height - 10))
        }
    }
}