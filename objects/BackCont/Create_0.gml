viewx = 0
viewy = 0
viewx2 = 0
viewy2 = 0

shake = 0
screen = -1
shad = surface_create(view_width, view_height)
surface_set_target(shad)
draw_clear_alpha(c_black, 0)
surface_reset_target()

shadow_color = c_black

area = GameCont.area

if area == 2 shadow_color = 68872

if area == 4 shadow_color = 786950

if area == 5 shadow_color = 4461326

if area == 7 shadow_color = 65805

if area == 101 shadow_color = 4401921

if area == 102 shadow_color = 1179657

if area == 103 shadow_color = 1310738

if area == 104 shadow_color = 66

if area == 105 shadow_color = 65556

if area == 106 shadow_color = 9184256

if area == 107 shadow_color = 1310738

alarm[0] = 1
alarm[1] = 120

try {
    var c = global.customshadowcolors[$ string(area)]

    if c != undefined && is_array(c) && array_length(c) == 3 {
        shadow_color = make_color_rgb(real(c[0]), real(c[1]), real(c[2]))
    }
} catch (e) {
    print_error(e.longMessage)
}