if !instance_exists(Portal) {
    draw_set_color(c_black)
    draw_rectangle(0, view_height, view_width, view_height - 32, 0)
    draw_set_color(c_white)

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)

    draw_text_nt(view_width / 2, view_height - 18, "@s" + loc(text[pos]))

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
}

draw_set_color(c_lime)

if !global.pc_build && !UberCont.opt_gamepad {
    switch pos {
        case 0:
            with JoystickMove {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break

        case 1:
            with ButtonAct {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
                alpha += 0.4
            }
            break

        case 2:
            with ButtonSwap {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break

        case 3:
            with ButtonActive {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break
    }
}

wave += 0.1
if wave > 6.2 wave = 0

draw_set_color(c_white)