function scrShadows() {
    //shadow works

    if instance_exists(GenCont) exit

    if !surface_exists(shad) {
        shad = surface_create(view_width, view_height)
        surface_set_target(shad)
        draw_clear_alpha(c_black, 0)
        surface_reset_target()
    }

    surface_set_target(shad)
    draw_clear_alpha(c_black, 0)

    try {
        for (var i = 0; i < ds_list_size(global.lis_walls_visible); i++) {
            with global.lis_walls_visible[| i] {
                if !position_meeting(x, y + 16, TopSmall) {
                    draw_sprite_ext(outspr, outindex, x - view_xview, y + 2 + 16 - view_yview, 1, - 1, 0, c_black, 1)
                }
            }
        }

        with Crown
        if visible draw_sprite(shd16, 0, x - view_xview, y - view_yview + 3)

        with CrownPickup
        draw_sprite(shd16, 0, x - view_xview, y - view_yview + 3)

        with CarThrow
        draw_sprite(shd32, 0, x - view_xview, y - view_yview)

        with CampChar
        draw_sprite(race == 13 ? shd96 : shd24, 0, x - view_xview, y - view_yview)

        with chestprop
        draw_sprite(shd24, 0, x - view_xview, y - view_yview - 1)

        with Mimic
        draw_sprite(shd24, 0, x - view_xview, y - view_yview)

        with BigWeaponChest
        draw_sprite(shd32, 0, x - view_xview, y - view_yview)

        with SnowBotCar
        draw_sprite(shd32, 0, x - view_xview, y - view_yview)

        with BigDogExplo
        draw_sprite(shd96, 0, x - view_xview, y - view_yview)

        with CrystalShield {
            if image_speed = 0 draw_sprite(shd64, 0, x - view_xview, y - view_yview + 2)
        }

        with hitme
        if object_is_ancestor(object_index, hitme) && visible {
            draw_sprite(spr_shadow, 0, x - view_xview + spr_shadow_x, y - view_yview + spr_shadow_y)
        }

        with LilHunterFly {
            draw_sprite(spr_shadow, 0, x - view_xview + spr_shadow_x, y - view_yview + spr_shadow_y)
        }
		
		with Yeti {
			if sprite_index != sprYetiBurrowed
			&& (sprite_index != sprYetiAppear or image_index >= 5)
			&& (sprite_index != sprYetiDisappear or image_index < 3)
				draw_sprite(shd48, 0, x - view_xview, y - view_yview)
		}
		
        with RavenFly
        if isset("spr_shadow_y") {
            draw_sprite(spr_shadow, 0, x - view_xview + spr_shadow_x, y - view_yview + spr_shadow_y)
        }
    } catch (e) {
        print(e.message)
    }

    surface_reset_target()
}