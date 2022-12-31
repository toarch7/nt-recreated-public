draw_set_blend_mode(bm_add)
draw_sprite_ext(sprite_index, 0, x, y, 2, 1, 45, c_white, 1 - point_distance(x, y, view_xview + view_width / 2, (view_yview + view_height / 2)) / 200)
draw_set_blend_mode(bm_normal)