function sprite_replace_frames(spr, frames) {
    var n = sprite_get_number(spr),
		w = sprite_get_width(spr),
		h = sprite_get_height(spr)

    var path = "./replacedsprites/repl" + string(spr) + ".png"

    if !(w or h or n)
		return undefined

    sprite_strip_save(spr, "replacedsprites/" + string(spr) + ".png")
    array_push(global.customSprites, spr)

    var s = surface_create(w * n, h)
    surface_set_target(s)

    for (var i = 0; i < n; i++) {
        if i < array_length(frames) {
            var spr2 = frames[i]

            if spr2 {
                draw_sprite(spr2, 0, i * w + sprite_get_xoffset(spr2), sprite_get_yoffset(spr2))

                continue
            }
        }

        draw_sprite(spr, i, i * w + sprite_get_xoffset(spr), sprite_get_yoffset(spr))
    }

    surface_reset_target()

    surface_save(s, path)

    surface_free(s)

    if sprite_replace(spr, path, n, 0, 0, sprite_get_xoffset(spr), sprite_get_yoffset(spr)) {

    } else printc("[!!!] Failed to replace sprite " + sprite_get_name(spr), c_red)
}