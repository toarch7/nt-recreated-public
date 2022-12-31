gunspr = sprBanditGun
if ((gunangle <= 180) && (spr_idle != sprAllyAppear)) draw_sprite_ext(gunspr, - 1, (x + lengthdir_x((-wkick), gunangle)), (y + lengthdir_y((-wkick), gunangle)), 1, right, gunangle, c_white, 1)
draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)
if (GameCont.area == 101) draw_sprite(sprPlayerBubble, - 1, x, y)
if ((gunangle > 180) && (spr_idle != sprAllyAppear)) draw_sprite_ext(gunspr, - 1, (x + lengthdir_x((-wkick), gunangle)), (y + lengthdir_y((-wkick), gunangle)), 1, right, gunangle, c_white, 1)