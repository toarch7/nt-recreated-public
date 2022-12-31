var yoff = 0

if instance_exists(creator) && sprite_index != spr_disappear {
    shieldright = 1

    if creator.hspeed < 0 {
        shieldright = -1
    }

    yoff = -3

    if creator.ultra == 2 {
        if creator.bskin {
            if !creator.speed {
                draw_sprite_ext(sprShieldBIdleBack, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
            } else {
                draw_sprite_ext(sprShieldBWalkBack, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
                walk += 0.4
            }
        } else if !creator.speed {
            draw_sprite_ext(sprShieldIdleBack, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
        } else {
            draw_sprite_ext(sprShieldWalkBack, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
            walk += 0.4
        }
    }
}

if time >= 28 {
    draw_sprite(sprite_index, - 1, x + random_spread(1), y + yoff)
} else {
    draw_sprite(sprite_index, - 1, x, y + yoff)
}

if instance_exists(creator) && creator.index == global.index {
    if creator.ultra == 2 && sprite_index != spr_disappear {
        if creator.bskin {
            if !creator.speed {
                draw_sprite_ext(sprShieldBIdleFront, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
            } else {
                draw_sprite_ext(sprShieldBWalkFront, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
            }
        } else if !creator.speed {
            draw_sprite_ext(sprShieldIdleFront, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
        } else {
            draw_sprite_ext(sprShieldWalkFront, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
        }
    }

    if skill_get(5) {
        var _f = instance_nearest(mouse_x, mouse_y, Floor)
        var _px = _f.x + _f.sprite_width / 2
        var _py = _f.y + _f.sprite_height / 2

        draw_set_alpha(0.5)
        draw_sprite(creator.spr_idle, creator.image_index, _px, _py)
        draw_set_alpha(0.3)
        draw_sprite(spr_idle, 3, _px, _py)
        draw_set_alpha(1)
    }
}