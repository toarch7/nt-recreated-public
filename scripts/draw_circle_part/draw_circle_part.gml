/// @description draw_circle_part(x,y,rad,width,percent)
/// @param x
/// @param y
/// @param rad
/// @param width
/// @param percent
function draw_circle_part(x, y, rad, width, percent) {
    var col = draw_get_color()
    var alpha = draw_get_alpha()
    draw_primitive_begin(pr_trianglestrip)

    for (var i = 0; i <= percent * 360; i += 15) {
        draw_vertex_color(x + lengthdir_x(rad, i), y + lengthdir_y(rad, i), col, alpha)
        draw_vertex_color(x + lengthdir_x(rad + width, i), y + lengthdir_y(rad + width, i), col, alpha)
    }

    draw_primitive_end()
}