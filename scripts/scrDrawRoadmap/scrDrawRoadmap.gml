/// @description scrDrawRoadmap(x,y,pos,cont)
/// @param x
/// @param y
/// @param pos
function scrDrawRoadmap(_x, _y, _pos, cont = GameCont) {
    _x = round(_x)
    _y = round(_y)

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)

    draw_set_color(c_white)
    draw_sprite(sprScoreSplat, 2, _x - 48, _y - 24)
    draw_sprite(sprScoreSplat, 2, _x + 48, _y - 24)
    draw_text_shadow(_x - 70, _y - 25, area_get_name(cont.area, cont.subarea, cont.loops))
    draw_text_shadow(_x + 36, _y - 25, string(cont.kills))
    draw_sprite(sprKillsIcon, 0, _x + 24, _y - 23)
    draw_set_color(c_white)

    var wx = 0
    var wy = 0
    var dir = 0
    var width = 1

    _x += 11

    draw_set_color(c_black)
    repeat min(_pos, cont.waypoints) {
        var lx = wx
        var ly = wy

        if cont.waypnt[dir] >= 100 {
            wy = 9
        } else {
            wx = ((cont.waypnt[dir] - 1) * 9) + ((cont.waysub[dir] - 1) * 9) + (floor(cont.waypnt[dir] / 2) * 18)
            wy = 0
        }

        if cont.waypnt[dir] != 0 {
            draw_line_pixel(_x + wx - 74, _y + wy + 1, _x + lx - 74, _y + ly + 1) //, width)
        }

        if (cont.waysub[dir] == 1) or(cont.waypnt[dir] >= 100) {
            draw_sprite(sprMapDotOut, 0, _x + wx - 75, _y + wy)
        }

        dir += 1
    }

    wx = 0
    wy = 0

    var mapcol = make_color_hsv(((cont.loops - 1) * 39) % 255, 200, 200)

    if cont.loops - global.hardmode <= 0 {
        mapcol = c_white
    }

    draw_sprite(sprMap, 0, _x - 11, _y)
    draw_sprite_ext(sprMap, 1, _x - 11, _y, 1, 1, 0, mapcol, 1)

    dir = 0
    repeat min(_pos, cont.waypoints) {
        var col = make_color_hsv((cont.waylps[dir] * 39) % 255, 200, 200)

        var lx = wx
        var ly = wy

        if cont.waypnt[dir] >= 100 {
            wy = 9
        } else {
            wx = ((cont.waypnt[dir] - 1) * 9) + ((cont.waysub[dir] - 1) * 9) + (floor(cont.waypnt[dir] / 2) * 18)
            wy = 0
        }

        draw_set_color(col)

        if cont.waypnt[dir] != 0 {
            draw_line_pixel(_x + wx - 75, _y + wy, _x + lx - 75, _y + ly) //, width)
        }

        if (cont.waysub[dir] == 1) or(cont.waypnt[dir] >= 100) {
            draw_sprite_ext(sprMapDot, 0, _x + wx - 75, _y + wy, 1, 1, 0, col, 1)
        }

        dir += 1
    }

    draw_set_color(c_white)

    var names = struct_keys(UberCont.playerinstances)

    var positions = [
        [-3, - 3],
        [3, 3],
        [3, - 3],
        [-3, 3]
    ]

    for (var i = 0; i < min(4, KeyCont.players); i++) {
        var pinst = playerinstance_get(names[i])

        if is_undefined(pinst) continue

        var sprt = sprPlayerMapIcon
        var offx = 0
        var offy = 0

        if KeyCont.players > 1 {
            offx = positions[i, 0]
            offy = positions[i, 1]
        }

        if pinst.skin {
            sprt = sprPlayerMapIconSkin
        }

        if instance_exists(UberCont) && UberCont.paused {
            if pinst.race == 9 && pinst.hp <= 0 {
                sprt = sprMapIconChickenHeadless
            } else if pinst.race == 10 && pinst.skin && cont.area == 5 {
                sprt = sprMapIconRebelBHooded
            }
        }

        draw_sprite(sprt, pinst.race, _x + offx - 75 + wx, _y + wy + offy)
    }
}

function draw_line_pixel(x1, y1, x2, y2) {
    y1++y2++draw_sprite_ext(sprPixel, 0, x1, y1, point_distance(x1, y1, x2, y2), 1, point_direction(x1, y1, x2, y2), draw_get_color(), draw_get_alpha())
}