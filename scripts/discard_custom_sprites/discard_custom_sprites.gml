function discard_custom_sprites(fast = 0) {
    if !fast {
        // restore sprites
        for (var i = 0; i < array_length(global.customSprites); i++) {
            var s = global.customSprites[i]
            var p = "replacedsprites/" + string(s) + ".png"

            sprite_replace(s, p, sprite_get_number(s), 0, 0, sprite_get_xoffset(s), sprite_get_yoffset(s))
        }
    }

    global.customSprites = []
}