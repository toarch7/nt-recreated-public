draw_set_blend_mode(bm_add)
draw_sprite_ext(sprLaser, - 1, x, y, 1000, 1, 270, c_white, 1)
if ammo < 10 and place_meeting(mouse_x, mouse_y, Floor) draw_sprite_ext(sprLaser, - 1, mouse_x, mouse_y, 1000, 1, 270, c_white, 1)
draw_set_blend_mode(bm_normal)