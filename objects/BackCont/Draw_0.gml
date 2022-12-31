//draw
with Scorch {
    draw_sprite(sprScorchTop, image_index, x, y)
}

if surface_exists(shad) {
    draw_set_alpha(0.4)
    d3d_set_fog(1, shadow_color, depth, depth + 1)
    draw_surface(shad, view_xview, view_yview)
    d3d_set_fog(0, 0, 0, 0)
    draw_set_alpha(1)
}