if instance_exists(Spiral) || !(ok && index > 0.4) exit

var _width = gui_w,
	_height = gui_h,
	_shadow_color = c_black,
	_background_color = c_black

with (BackCont) {
    _shadow_color = shadow_color
    _background_color = merge_color(_shadow_color, c_black, 0.5)
}
	
draw_set_color(_background_color)
	
draw_align(fa_center, fa_middle)

var _string = "@y" + loc(str1) + "#" + "@s" + loc(str2), _y = _height - 28
	
if achiev == Achievement.BOSS_CAPTAIN {
    _string = "@b" + loc(str1) + "#" + "@w" + loc(str2)
}
else if achiev == Achievement.BOSS_THRONE || achiev == Achievement.BOSS_THRONE2 {
    _string = "@g" + loc(str1) + "#" + "@w" + loc(str2)
}

draw_sprite_stretched_ext(sprAchievementSplash, 0, 0, _y - 6,
	_width, min(index * 8, string_height(string_hash_to_newline(_string)) + 13),
	draw_get_color(), draw_get_alpha())

draw_set_color(c_white)

if index > 1 {
    if string_width(string_hash_to_newline(_string)) < _width * 0.8 {
        var _scale = 0.75, _color = merge_color(c_white, _shadow_color, 0.75)
        draw_sprite_ext(sprButtonAchievements, 0, 32, _y + index * 2 - _scale, _scale, _scale, 0, c_black, 1)
        draw_sprite_ext(sprButtonAchievements, 0, 32, _y + index * 2, _scale, _scale, 0, _color, 1)
        draw_sprite_ext(sprButtonAchievements, 0, _width - 32, _y + index * 2 - _scale, _scale, _scale, 0, c_black, 1)
        draw_sprite_ext(sprButtonAchievements, 0, _width - 32, _y + index * 2, _scale, _scale, 0, _color, 1)
    }
	
    draw_text_nt(_width / 2, _y + index * 2, _string)
}

draw_align()