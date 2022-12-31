if control = 1 draw_sprite_ext(sprInspectorControl, - 1, x, y, right, 1, angle, c_white, 1) if gunangle <= 180 draw_sprite_ext(sprPopoSlugger, - 1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1) draw_sprite_ext(sprite_index, - 1, x, y, right, 1, angle, c_white, 1)
if gunangle > 180 draw_sprite_ext(sprPopoSlugger, - 1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1)

if instance_exists(GameCont) && GameCont.area == 101 {
    draw_sprite(sprPlayerBubble, - 1, x, y)
}