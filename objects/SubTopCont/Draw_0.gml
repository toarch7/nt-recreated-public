if lockstep_stop
	exit

if instance_exists(GenCont) exit

if UberCont.opt_bloom {
	scrDrawBloom()
}
	
var _list = global.lis_walls_visible,
	_count = ds_list_size(_list)
	
for (var i = _count - 1; i >= 0; --i) {
    with _list[| i] {
		draw_sprite_part_ext(outspr, outindex, l, r, w, h,
			x - 4 + l, y - 12 + r, image_xscale, image_yscale, image_blend, image_alpha)
	}
}
	
with TopSmall {
    draw_sprite(sprite_index, -1, x, y - 8)
}
	
with Wall {
	draw_sprite(topspr, image_index, x, y - 8)
}
	
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
    draw_sprite_ext(sprite_index, -1, x, y + z, right, 1, 0, c_white, 1)
}

with LilHunterFly {
    draw_sprite_ext(sprite_index, -1, x, y + z, right, 1, 0, c_white, 1)
}

with StreetLight
draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, 0, c_white, 1)

with BigTV {
    event_perform(ev_draw, 0) //draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, 0, c_white, 1)
}

with Bubble
draw_sprite(sprite_index, -1, x, y)

with Player {
    if visible {
        if scr_skill_get(27) && !instance_exists(StrongSpiritRefill) && (spirit or spirit_index < 8) {
            var _y = y - 2 + sin(spirit_anim)
            draw_sprite(sprStrongSpirit, spirit_index, x, _y)

            gpu_set_blendmode(bm_add)
            draw_sprite(sprStrongSpirit, spirit_index, x, _y)
            gpu_set_blendmode(bm_normal)
        }

        if hammerhead && hammering {
            draw_sprite(sprHammerHead, -1, x, y)
        }
    }
}

with Nothing2Appear
draw_self()
