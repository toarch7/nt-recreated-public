function scrGameContDrawGUI() {
    if !instance_exists(Menu) && UberCont.opt_timer && (!instance_exists(Credits) or(instance_exists(Credits) && !Credits.visible)) {
        draw_set_color(c_white)
        draw_set_halign(fa_right)
        draw_set_valign(fa_top)
        time = scrAddZero(minutes, 1) + ":" + scrAddZero(seconds, 1) + "." + scrAddZero(round(timer / 30 * 100), 1)
        draw_text_shadow(view_width - 1, view_height - 10, time)
        draw_set_halign(fa_left)
    }

    if instance_exists(GameOver) or instance_exists(Player) or UberCont.paused or room == romInit {
        dir = 1
        dix = 0

        if coopultra {
            draw_sprite(sprUltraIconCoopHUD, coopultra - 1, view_width - 12 - 16 * dix, 13)
            dix++
        } else if ultra {
            draw_sprite(sprUltraIconHUD, ultr_indx[race, ultra], view_width - 12 - 16 * dix, 13)
            dix++
        }

        for (var dir = 0; dir < ds_list_size(skills); dir++) {
            var __sk = skills[| dir]

            if __sk == patienceskill
            continue

            if __sk == 25 {
                if patienceskill {
                    draw_sprite(sprSkillIconHUD, patienceskill, view_width - 12 - 16 * dix, 12)
                    draw_sprite(sprPatienceIconHUD, 0, view_width - 12 - 16 * dix, 12)
                } else draw_sprite(sprSkillIconHUD, __sk, view_width - 12 - 16 * dix, 12)

                dix++
                continue
            }

            draw_sprite(sprSkillIconHUD, __sk, view_width - 12 - 16 * dix, 12)
            dix++
        }
    }
}