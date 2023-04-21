draw_set_halign(fa_left)
draw_set_valign(fa_top)

var text = self[$ "text"]
var w = string_width("> ")
var yy = round(display_get_gui_height() * 1.25)
var read = 0

if !UberCont.opt_console {
    yy = display_get_gui_height() * 1.9
    read = 1
} else if os_type == os_android {
    yy = round(yy * 0.65)
}

if global.console_active {
    display_set_gui_size(width * 2, height * 2)

    draw_set_font(fontConsole)

    draw_set_color(c_black)
    draw_set_alpha(0.6)

    draw_rectangle(0, 0, display_get_gui_width(), yy, 0)

    draw_set_alpha(1)

    var _x = 14
    var _y = yy - string_height("Aa") - 2

    var len = array_length(global.log_output)

    for (var i = len - 1; i >= 0; i--) {
        var str = global.log_output[i],
            c = global.log_color[i]

        if c == (c_white - 1) {
            text(_x - w + 4, _y, "> " + str, c, 1)
        } else text(_x, _y, str, c, 1)

        _y -= string_height(str)
    }

    if !read {
        draw_set_color(c_black)
        draw_set_alpha(0.3)
        draw_rectangle(0, yy, display_get_gui_width(), yy + string_height("Aa" + keyboard_string), 0)

        text(14 - string_width("> "), yy, "> " + keyboard_string + cursor, c_white, 1)
    }

    alert = ""

    display_set_gui_size(width, height)
} else if alert != "" {
    draw_set_halign(fa_center)
    text(display_get_gui_width() / 2, 48, alert, c_red)
}

draw_set_font(fntM1)

if os_type == os_android && (!read or global.console_active) {
    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(view_width - 36, 18 + 12, view_width - 18, 36 + 12, 0)
    draw_set_color(c_white)
    draw_set_alpha(1)

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text_shadow(view_width - 26, 28 + 12, "~")
    draw_set_halign(fa_left)
    draw_set_valign(fa_top)

    if mouse_check_button_pressed(mb_left) {
        if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), view_width - 36, 18 + 12, view_width - 18, 36 + 12) open = 1
    }
}

draw_set_color(c_white)
draw_set_alpha(1)