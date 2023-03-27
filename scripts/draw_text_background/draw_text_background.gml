/// @description draw_text_background(x,y,text)
/// @param x
/// @param y
/// @param text
function draw_text_background(_x, _y, _text) {
	var _str = string_hash_to_newline(_text),
		width = ceil(string_width(_str) / 2) + 4,
		height = string_height(_str)
	
    draw_rectangle_colour(_x - width, _y - 2, _x + width, _y + height, c_tooltip, c_tooltip, c_tooltip, c_tooltip, 0)
	
    draw_text(_x, _y, _str)
}