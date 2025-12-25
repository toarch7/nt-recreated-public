if lockstep_stop
	exit

var _txt, _sprite = sprLevelUpText;

scrDrawSpiral()

draw_set_halign(fa_center)
draw_set_valign(fa_top)

if instance_exists(CrownIcon) {
	_txt = loc("LevCont:SelectCrown:1", "@sCHOOSE WISELY")
	_sprite = sprPickCrownText
}
else if instance_exists(UltraIcon) {
	if (instance_exists_var(UltraIcon, "race", Race.Robot)) {
		_txt = loc("LevCont:SelectUltraRobot", "@sINSTALL @gULTRA@s UPDATE")
	}
	else {
		_txt = loc("LevCont:SelectUltra", "@sPICK YOUR @gULTRA@s MUTATION")
	}
	 _sprite = sprLevelUltraText
}
else if instance_exists(SkillIcon) {
	if (scrPlayerCountRace(Race.Robot, true)) {
		_txt = loc_fmt_either($"LevCont:InstallUpdates:{GameCont.skillpoints}", "LevCont:InstallUpdates",
			"@sINSTALL % UPDATES@s#DO NOT TURN OFF ROBOT", GameCont.skillpoints)
	}
	else {
		_txt = loc_fmt_either($"LevCont:SelectMutations:{GameCont.skillpoints}", "LevCont:SelectMutations",
			"@sSELECT % MUTATIONS", GameCont.skillpoints)
	}
}
else exit

if splat {
	if (splatimg < sprite_get_number(sprMutationSplat) - 1) splatimg ++
    draw_sprite(sprMutationSplat, splatimg, view_width / 2, view_height - 31)
}

//
var _subimage = (appear > view_height * 0.7) ? 0 : 2,
	_name = scrMenuButtonName(_sprite, _subimage),
	_x = view_xview + view_width / 2 + appear,
	_y = view_yview + 48

if is_string(_name) {
	draw_text_bigname(_x, _y, _name, _subimage == 0 ? c_white : c_ultra)
}
else {
	draw_sprite_ext(_sprite, _subimage, _x + 1, _y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(_sprite, _subimage, _x + 1, _y + 0, 1, 1, 0, c_black, 1)
	draw_sprite_ext(_sprite, _subimage, _x + 0, _y + 1, 1, 1, 0, c_black, 1)
	draw_sprite(_sprite, _subimage, _x, _y)
}

draw_text_nt(view_xview + view_width / 2 + 1, view_yview + 75 - appear, "@s" + _txt)

appear = lerp(appear, 0, 0.75)

draw_set_halign(fa_left)
draw_set_valign(fa_top)