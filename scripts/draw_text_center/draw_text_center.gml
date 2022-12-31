/// @description draw_text_center(x,y,text)
/// @param x
/// @param y
/// @param text
function draw_text_center(argument0, argument1, argument2) {
    draw_set_halign(fa_center)
    draw_text(argument0, argument1, string_hash_to_newline(argument2))
    draw_set_halign(fa_left)



}