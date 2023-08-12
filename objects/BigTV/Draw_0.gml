draw_self()

if instance_exists(Cinematic) {
    if sprite_index == sprBigTVOn && player {
        if playersprite == spr_gosit && drawframe >= sprite_get_number(playersprite) {
            playersprite = spr_sit
            drawframe = 0
        }

        if player.wep draw_sprite_ext(wep_sprt[player.wep], 0, x + 1, y, 1, 1, 75, c_white, 1) if player.bwep draw_sprite_ext(wep_sprt[player.bwep], 0, x + 1, y, 1, 1, 110, c_white, 1)

        draw_sprite(playersprite, drawframe, x, y)

        if skill_get(27) && !instance_exists(StrongSpiritRefill) && player.spirit {
            var _y = y - 2 + sin(player.spirit_anim)
            draw_sprite(sprStrongSpirit, player.spirit_index, x + 1, _y)

            gpu_set_blendmode(bm_add)
            draw_sprite(sprStrongSpirit, player.spirit_index, x + 1, _y)
            gpu_set_blendmode(bm_normal)
        }

        with GammaGuts {
            x = other.x
            y = other.y

            gpu_set_blendmode(bm_add)
            draw_self()
            gpu_set_blendmode(bm_normal)
        }

        draw_sprite_ext(sprBigTVLines, 0, x, y, 1, 1, 0, c_white, (round(drawframe) % 4 == 0) ? 0.1 : 0.15)
    }
}