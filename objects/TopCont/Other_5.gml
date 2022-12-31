if darkness = 1 {
    if (surface_exists(dark)) {
        surface_set_target(dark);
        draw_clear(0);
        surface_reset_target();
        surface_free(dark);
    }
}