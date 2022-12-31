function scrDarkness() {
    if instance_exists(GenCont) exit

    if !surface_exists(dark) {
        dark = surface_create(view_width, view_height)
    }

    surface_set_target(dark)

    try {
        draw_clear(c_white)

        var p = noone
        with Player
        if is_me {
            p = id
        }

        if instance_exists(p) {
            if p.race == 3 {
                draw_clear(c_gray)
            }
        } else draw_clear(c_gray)

        draw_set_color(c_gray)

        if GameCont.area == 102 or GameCont.area == 2 {
            with Floor
            if styleb {
                draw_circle(x + 16 - view_xview, y + 16 - view_yview, 32 + random(4), 0)
            }
        }

        with Player
        draw_circle(x - view_xview, y - view_yview, 130 + random(4), 0)

        with Revive
        draw_circle(x - view_xview, y - view_yview, 130 + random(4), 0)

        with HyperCrystal
        draw_circle(x - view_xview, y - view_yview, 30 + dist + random(4), 0)

        with MeatExplosion
        draw_circle(x - view_xview, y - view_yview, 140 + random(4), 0)

        with Explosion
        draw_circle(x - view_xview, y - view_yview, 160 + random(4), 0)

        with Portal
        draw_circle(x - view_xview, y - view_yview, 120 + random(8), 0)

        with IDPDSpawn
        draw_circle(x - view_xview, y - view_yview, 60 + random(8), 0)

        with VanSpawn
        draw_circle(x - view_xview, y - view_yview, 120 + random(8), 0)

        with Tangle
        draw_circle(x - view_xview, y - view_yview, 110 + random(4), 0)

        with Ally
        draw_circle(x - view_xview, y - view_yview, 90 + random(4), 0)

        with Crystal
        draw_circle(x - view_xview, y - view_yview, 90, 0)

        with TopDecalCave
        draw_circle(x - view_xview, y - view_yview - 8, 120, 0)

        with Torch
        draw_circle(x - view_xview, y - view_yview, 90 + random(4), 0)

        with Barrel
        draw_circle(x - view_xview, y - view_yview, 90 + random(4), 0)

        with Terminal
        draw_circle(x - view_xview, y - view_yview, 60 + random(4), 0)

        with Flame
        draw_circle(x - view_xview, y - view_yview, 70 + random(4), 0)

        with PopoNade
        draw_circle(x - view_xview, y - view_yview, 70 + random(4), 0)

        with JockRocket
        draw_circle(x - view_xview, y - view_yview, 70 + random(4), 0)

        with CrownPickup
        draw_circle(x - view_xview, y - view_yview, 72, 0)

        draw_set_color(c_black)

        with Player {
            if race == 3 {
                draw_circle(x - view_xview, y - view_yview, 80 + random(3), 0)
            } else draw_circle(x - view_xview, y - view_yview, 45 + random(3), 0)
        }

        with Revive {
            if race == 3 {
                draw_circle(x - view_xview, y - view_yview, 80 + random(3), 0)
            } else draw_circle(x - view_xview, y - view_yview, 45 + random(3), 0)
        }

        with HyperCrystal
        draw_circle(x - view_xview, y - view_yview, 30 + dist / 10 + random(3), 0)

        with Explosion
        draw_circle(x - view_xview, y - view_yview, 110 + random(3), 0)

        with Portal
        draw_circle(x - view_xview, y - view_yview, 40 + random(6), 0)

        with IDPDSpawn
        draw_circle(x - view_xview, y - view_yview, 20 + random(6), 0)

        with VanSpawn
        draw_circle(x - view_xview, y - view_yview, 40 + random(6), 0)

        with MeatExplosion
        draw_circle(x - view_xview, y - view_yview, 40 + random(3), 0)

        with Tangle
        draw_circle(x - view_xview, y - view_yview, 20 + random(3), 0)

        with Crystal
        draw_circle(x - view_xview, y - view_yview, 30, 0)

        with TopDecalCave
        draw_circle(x - view_xview, y - view_yview - 8, 45, 0)

        with Ally
        draw_circle(x - view_xview, y - view_yview, 30, 0)

        with Flame
        draw_circle(x - view_xview, y - view_yview, 30 + random(3), 0)

        with PopoNade
        draw_circle(x - view_xview, y - view_yview, 30 + random(3), 0)

        with JockRocket
        draw_circle(x - view_xview, y - view_yview, 30 + random(3), 0)

        with Torch
        draw_circle(x - view_xview, y - view_yview, 30 + random(3), 0)

        with Barrel
        draw_circle(x - view_xview, y - view_yview, 30 + random(3), 0)

        with Terminal
        draw_circle(x - view_xview, y - view_yview, 20 + random(3), 0)

        with CrownPickup
        draw_circle(x - view_xview, y - view_yview, 32, 0)
    } catch (e) {
        print(e.messag)
    }

    surface_reset_target()
}