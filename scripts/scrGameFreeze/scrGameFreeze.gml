function scrGameFreeze() {
    var scrn = surface_create(view_width, view_height)

    surface_set_target(scrn)
    draw_surface(application_surface, 0, 0)

    draw_set_blend_mode(bm_add)
    with BackCont {
        if surface_exists(shad) {
            draw_set_alpha(0.3)
            d3d_set_fog(1, shadow_color, depth, depth + 1)
            draw_surface(shad, 0, 0)
            d3d_set_fog(0, 0, 0, 0)
            draw_set_alpha(1)
        }
    }
    draw_set_blend_mode(bm_normal)
    /*
	draw_set_color(c_black)
	draw_set_blend_mode(bm_add)
	draw_rectangle(0, 0, view_width, view_height, 0)
	draw_set_blend_mode(bm_normal)
	draw_set_color(c_white)*/

    surface_reset_target()

    with instance_create(view_xview, view_yview, PauseImage) {
        surf = scrn

        instance_deactivate_all(1)
        instance_activate_object(CoopController)
        instance_activate_object(UberCont)
    }
}