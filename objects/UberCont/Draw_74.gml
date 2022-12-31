/*display_set_gui_size(surface_get_width(application_surface), surface_get_height(application_surface))

shader_set(shdTest)

shader_set_uniform_f(uf_texel, 1 / surface_get_width(application_surface))
shader_set_uniform_f(uf_blur, blur_level)

draw_surface(application_surface, 0, 0)

surface_set_target(application_surface)
draw_set_color(c_black)
draw_set_blend_mode(bm_add)
draw_rectangle(0, 0, surface_get_width(application_surface), surface_get_height(application_surface), 0)
draw_set_blend_mode(bm_normal)
draw_set_color(c_white)
surface_reset_target()

shader_reset()

display_set_gui_size(view_width, view_height)

show_debug_message(blur_level)

if mouse_wheel_up() {
	blur_level ++
	
	if blur_level > 10
		blur_level = 10
} else if mouse_wheel_down() {
	blur_level --
	
	if blur_level < 0
		blur_level = 0
}*/

if opt_sideart > 0 {
    var n = max_view_width / 64
    var nh = ceil(view_height / 64) + 1

    for (var i = 1; i <= n; i++) {
        var yy = 0

        repeat nh {
            draw_sprite(sprSideArt, opt_sideart, i * -64, yy)
            draw_sprite(sprSideArt, opt_sideart, view_width - 64 + i * 64, yy)

            yy += 64
        }
    }
}