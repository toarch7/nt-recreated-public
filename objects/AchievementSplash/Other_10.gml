if instance_exists(Spiral) exit

var width = display_get_gui_width()
var height = display_get_gui_height()

if ok && index > 0.4 {
    var shcol = c_black
    var bcol = c_black

    if instance_exists(BackCont) {
        shcol = BackCont.shadow_color
        bcol = merge_color(shcol, c_black, 0.5)
    }

    draw_set_color(bcol)

    draw_set_halign(fa_center)

    var str = "@y" + loc(str1) + "#" + "@s" + loc(str2)
    var _y = height - 28

    if achiev == 42 {
        str = "@b" + loc(str1) + "#" + "@w" + loc(str2)
    } else if achiev == 33 or achiev == 34 {
        str = "@g" + loc(str1) + "#" + "@w" + loc(str2)
    }

    draw_sprite_stretched_ext(sprAchievementSplash, 0, 0, _y - 6, width, min(index * 8, string_height(string_hash_to_newline(str)) + 13), draw_get_color(), draw_get_alpha())
    draw_set_color(c_white)

    if index > 1 {
        if string_width(string_hash_to_newline(str)) < width * 0.8 {
            var c = merge_color(c_white, shcol, 0.75)
            var scale = 0.75
            draw_sprite_ext(sprButtonAchievements, 0, 32, _y + index * 2 - scale, scale, scale, 0, c_black, 1)
            draw_sprite_ext(sprButtonAchievements, 0, 32, _y + index * 2, scale, scale, 0, c, 1)
            draw_sprite_ext(sprButtonAchievements, 0, width - 32, _y + index * 2 - scale, scale, scale, 0, c_black, 1)
            draw_sprite_ext(sprButtonAchievements, 0, width - 32, _y + index * 2, scale, scale, 0, c, 1)
        }

        draw_text_nt(width / 2, _y + index * 2 - 8, str)
    }

    draw_set_halign(fa_left)

    draw_set_font(fntL)
}