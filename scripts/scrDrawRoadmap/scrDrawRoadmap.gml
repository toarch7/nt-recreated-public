/// @description scrDrawRoadmap(x,y,pos,_gamecont_data)
/// @param x
/// @param y
/// @param pos
function scrDrawRoadmap(_x, _y, _pos, _gamecont_data = GameCont) {
    _x = round(_x)
    _y = round(_y)

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)

    draw_set_color(c_white)
    draw_sprite(sprScoreSplat, 2, _x - 48, _y - 24)
    draw_sprite(sprScoreSplat, 2, _x + 48, _y - 24)
    draw_text_shadow(_x - 70, _y - 25, area_get_name(_gamecont_data.area, _gamecont_data.subarea, _gamecont_data.loops))
    draw_text_shadow(_x + 36, _y - 25, string(_gamecont_data.kills))
    draw_sprite(sprKillsIcon, 0, _x + 24, _y - 23)
    draw_set_color(c_white)

    var wx = 0
    var wy = 0
    var dir = 0
    var width = 1

    _x += 11

    draw_set_color(c_black)
    repeat min(_pos, _gamecont_data.waypoints) {
        var lx = wx
        var ly = wy

        if _gamecont_data.waypnt[dir] >= 100 {
            wy = 9
        } else {
            wx = ((_gamecont_data.waypnt[dir] - 1) * 9) + ((_gamecont_data.waysub[dir] - 1) * 9) + (floor(_gamecont_data.waypnt[dir] / 2) * 18)
            wy = 0
        }

        if _gamecont_data.waypnt[dir] != 0 {
            draw_line_pixel(_x + wx - 74, _y + wy + 1, _x + lx - 74, _y + ly + 1) //, width)
        }

        if (_gamecont_data.waysub[dir] == 1) or (_gamecont_data.waypnt[dir] >= 100) {
            draw_sprite(sprMapDotOut, 0, _x + wx - 75, _y + wy)
        }

        dir += 1
    }

    wx = 0
    wy = 0

    var mapcol = make_color_hsv(((_gamecont_data.loops - 1) * 39) % 255, 200, 200)

    if _gamecont_data.loops - global.hardmode <= 0 {
        mapcol = c_white
    }

    draw_sprite(sprMap, 0, _x - 11, _y)
    draw_sprite_ext(sprMap, 1, _x - 11, _y, 1, 1, 0, mapcol, 1)

    dir = 0
    repeat min(_pos, _gamecont_data.waypoints) {
        var col = make_color_hsv((_gamecont_data.waylps[dir] * 39) % 255, 200, 200)

        var lx = wx
        var ly = wy

        if _gamecont_data.waypnt[dir] >= 100 {
            wy = 9
        } else {
            wx = ((_gamecont_data.waypnt[dir] - 1) * 9) + ((_gamecont_data.waysub[dir] - 1) * 9) + (floor(_gamecont_data.waypnt[dir] / 2) * 18)
            wy = 0
        }

        draw_set_color(col)

        if _gamecont_data.waypnt[dir] != 0 {
            draw_line_pixel(_x + wx - 75, _y + wy, _x + lx - 75, _y + ly) //, width)
        }

        if (_gamecont_data.waysub[dir] == 1) || (_gamecont_data.waypnt[dir] >= 100) {
            draw_sprite_ext(sprMapDot, 0, _x + wx - 75, _y + wy, 1, 1, 0, col, 1)
        }

        dir += 1
    }

    draw_set_color(c_white)

    var _names = scr_playerinstances_get_all(),
		_count = array_length(_names)

    static _positions = [
        [-3, -3],
        [ 3,  3],
        [ 3, -3],
        [-3,  3]
    ]
	
    for (var i = 0; i < _count; ++i) {
        var _pinst = scr_playerinstance_find(_names[i])

        if is_undefined(_pinst) continue

        var _sprite = sprMapIcon, _xoff = 0, _yoff = 0

        if _count > 1 {
            _xoff = _positions[i, 0]
            _yoff = _positions[i, 1]
        }
		
        if instance_exists(UberCont) && UberCont.paused {
            if _pinst.is_race(Race.Chicken) && _pinst.hp <= 0 {
                _sprite = sprMapIconChickenHeadless
            }
			else if _pinst.is_race(Race.Rebel) && _pinst.skin && _gamecont_data.area == Area.City {
                _sprite = sprMapIconRebelBHooded
            }
        }
		
		var _img = scr_race_get_skin_subimage(_pinst.race, _pinst.skin)
		draw_sprite(_sprite, _img, _x + _xoff - 75 + wx, _y + wy + _yoff)
	}
}

function draw_line_pixel(x1, y1, x2, y2) {
    y1 ++
	y2 ++
	
	var _distance = point_distance(x1, y1, x2, y2),
		_direction = point_direction(x1, y1, x2, y2),
		_color = draw_get_color(),
		_alpha = draw_get_alpha()
	
	draw_sprite_ext(sprPixel, 0, x1, y1, _distance, 1, _direction, _color, _alpha)
}