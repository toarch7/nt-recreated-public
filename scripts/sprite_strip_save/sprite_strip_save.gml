function sprite_strip_save(spr, path) {
    var n = sprite_get_number(spr)
    var w = sprite_get_width(spr)
    var h = sprite_get_height(spr)

    if !(w or h or n) return undefined

    var s = surface_create(w * n, h)
    surface_set_target(s)

    for (var i = 0; i < n; i++) {
        draw_sprite(spr, i, i * w + sprite_get_xoffset(spr), sprite_get_yoffset(spr))
    }

    surface_reset_target()

    surface_save(s, path)

    surface_free(s)
}