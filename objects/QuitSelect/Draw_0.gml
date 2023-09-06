if lockstep_stop
	exit

x = view_xview + 8 //-(mouse_x-view_xview)*0.7
y = view_yview + 12


if selected = 1 draw_sprite(sprSelected, - 1, x, y - 48 + Menu.widescreen) draw_sprite_part(sprite_index, - 1, 8, 4, 16, 24, x, y - 48 + Menu.widescreen)