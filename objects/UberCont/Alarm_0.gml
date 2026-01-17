alarm[0] = 30


var _diff = current_time - timer_last_time,
	_elapsed = _diff * 0.001

timer_last_time = current_time

//time stats
tot_time += _elapsed

with (Player) if (is_me) {
	UberCont.ctot_time[race] += _elapsed
	break
}

if (daily_time) daily_time -= _elapsed

if (public && scrGameIsEventRun()
	&& (is_debug_overlay_open() || scr_debug_cheats_enabled())
) {
	global.__debug_immortality = false
	global.__debug_noreload = false
	global.__debug_infammo = false
	scr_debug_overlay_toggle()
}