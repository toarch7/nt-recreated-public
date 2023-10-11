if lockstep_stop
	exit

if instance_exists(GenCont) exit

try {
    if UberCont.opt_bloom {
		scrDrawBloom()
	}

    for (i = 0; i < ds_list_size(global.lis_walls_visible); i++) {
        with global.lis_walls_visible[| i]
        if instance_exists(id) {
            draw_sprite_part(outspr, outindex, l, r, w, h, x - 4 + l, y - 12 + r)
        }
    }

    /*with Top {
	    if active {
	        draw_sprite(sprite_index, -1, x + 16, y - 8)
	        draw_sprite(sprite_index, -1, x, y + 8)
	        draw_sprite(sprite_index, -1, x + 16, y + 8)
	        draw_sprite(sprite_index, -1, x, y - 8)
	    }
	}*/

    with TopSmall {
        draw_sprite(sprite_index, - 1, x, y - 8)
    }

    with Wall draw_sprite(topspr, image_index, x, y - 8)

    with TopPot {
        draw_sprite(sprite_index, image_index, x, y - 8)
    }

    for (var i = 0; i < array_length(bones); i++) {
        var obj = bones[i]

        if is_undefined(obj) {
            continue
        }

        with obj {
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1)
        }
    }

    with RavenFly {
        draw_sprite_ext(sprite_index, - 1, x, y + z, right, 1, 0, c_white, 1)
    }

    with LilHunterFly {
        draw_sprite_ext(sprite_index, - 1, x, y + z, right, 1, 0, c_white, 1)
    }

    with StreetLight
    draw_sprite_ext(sprite_index, - 1, x, y, image_xscale, 1, 0, c_white, 1)

    with BigTV {
        event_perform(ev_draw, 0) //draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, 0, c_white, 1)
    }

    with Bubble
    draw_sprite(sprite_index, - 1, x, y)

    with Player {
        if visible {
            if skill_get(27) && !instance_exists(StrongSpiritRefill) && (spirit or spirit_index < 8) {
                var _y = y - 2 + sin(spirit_anim)
                draw_sprite(sprStrongSpirit, spirit_index, x, _y)

                gpu_set_blendmode(bm_add)
                draw_sprite(sprStrongSpirit, spirit_index, x, _y)
                gpu_set_blendmode(bm_normal)
            }

            if hammerheads && hammerhead {
                draw_sprite(sprHammerHead, - 1, x, y)
            }
        }
    }

    with Nothing2Appear
    draw_self()
} catch (e) {
    print(e.message)
}