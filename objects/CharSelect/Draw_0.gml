/// @description Drawing

var _color = selected ? c_white : c_gray

can = scr_race_is_unlocked(race) || UberCont.weekly_run

draw_sprite_ext(can ? sprite_index : sprCharSelectLocked, race, x, y, 1, 1, 0, _color, 1)

if can && race && !UberCont.ctot_dead[race] {
    draw_sprite(sprNew, -1, bbox_right, y)
}

if instance_exists(Menu) {
	depth = Menu.depth - 1
}