if lockstep_stop
	exit

if gunangle <= 180 draw_sprite_ext(sprElitePopoGun, -1,
x + lengthdir_x(-wkick, gunangle),
y + lengthdir_y(-wkick, gunangle),
1, right, gunangle, c_white, 1)

if roll draw_sprite_ext(sprEliteGruntFlame, -1, x, y, 1, 1, angle, c_white, 1)

if sprite_exists(sprite_index) draw_sprite_ext(sprite_index, -1, x, y, right, 1, angle, c_white, 1)

if instance_exists(GameCont) && GameCont.underwater {
	draw_sprite(sprPlayerBubble, -1, x, y)
}

if gunangle > 180 draw_sprite_ext(sprElitePopoGun, -1,
x + lengthdir_x(-wkick, gunangle),
y + lengthdir_y(-wkick, gunangle),
1, right, gunangle, c_white, 1)

if instance_exists(GameCont) && GameCont.underwater draw_sprite(sprPlayerBubble, -1, x, y)