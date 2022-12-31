/// @description draw_text_background(x,y,text)
/// @param x
/// @param y
/// @param text
function draw_text_background(argument0, argument1, argument2) {
    __width = ceil(string_width(string_hash_to_newline(argument2)) / 2) + 4
    __height = string_height(string_hash_to_newline(argument2))

    draw_rectangle_colour(argument0 - __width, argument1 - 2, argument0 + __width, argument1 + __height, c_text_background, c_text_background, c_text_background, c_text_background, 0)
    draw_text(argument0, argument1, string_hash_to_newline(argument2))



}