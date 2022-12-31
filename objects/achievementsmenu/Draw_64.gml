var diy = 0,
    scale = 1
var vwhalf = view_width / 2 - 24

draw_set_valign(fa_center)

var split = 0

for (var i = 0; i < array_length(chiev_name); i++) {
    if i == 9 or i == 21 or i == 29 or i == 37 {
        split = 1
    }

    var _y = 52 + diy * 32 - ypos

    var name = chiev_name[i]
    var text = string_hash_to_newline(chiev_text[i])

    if chiev_hide[i] && !chiev_have[i] {
        name = "???"
        text = "???"
    }

    scale = clamp(1 + (vwhalf - string_width(text)) / vwhalf, 0.5, 1)

    if diy * 32 > ypos - 32 && diy * 32 < ypos + view_height {
        draw_set_halign(fa_left)
        draw_text_nt(8, _y, (chiev_have[i] ? "@g" : "@s") + name)

        draw_set_halign(fa_right)

        draw_set_color(c_black)
        draw_text_transformed(view_width - 8 + scale, _y + scale, text, scale, scale, 0)
        draw_text_transformed(view_width - 8, _y + scale, text, scale, scale, 0)

        draw_set_color(chiev_have[i] ? c_gray : c_dkgray)
        draw_text_transformed(view_width - 8, _y, text, scale, scale, 0)
    }

    if split {
        draw_sprite_ext(sprAchievementsMenuSeparator, 0, view_width / 2, _y + 32, 1, 1, 0, c_gray, 1)
        split = 0
        diy++
    }

    diy++
}

draw_set_color(c_white)

/*if hiddens {
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
    draw_text_nt(view_width / 2, _y + 32, loc_sfmt("+% HIDDEN", hiddens))
}*/

draw_set_color(c_black)

draw_rectangle(0, view_height - 32, view_width, view_height, 0)
draw_rectangle(0, 0, view_width, 32, 0)

draw_set_color(c_white)
draw_set_halign(fa_center)

draw_text_shadow(view_width / 2, 12, loc("ACHIEVEMENTS"))
draw_text_shadow(view_width / 2, 24, string(unlocks) + "/" + string(array_length(chiev_name)))

draw_set_halign(fa_left)
draw_set_valign(fa_top)