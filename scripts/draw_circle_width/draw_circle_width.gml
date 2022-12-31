/// @description draw_circle_width(x,y,rad,width)
/// @param x
/// @param y
/// @param rad
/// @param width
function draw_circle_width(x, y, radius, width) {
    var col = draw_get_color()
    var alpha = draw_get_alpha()

    draw_primitive_begin(pr_trianglestrip)

    for (var i = 0; i <= 360; i += 15) {
        draw_vertex_color(x + lengthdir_x(radius, i), y + lengthdir_y(radius, i), col, alpha)
        draw_vertex_color(x + lengthdir_x(radius + width, i), y + lengthdir_y(radius + width, i), col, alpha)
    }

    draw_primitive_end()
}