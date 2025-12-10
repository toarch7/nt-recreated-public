/// @function sleep
/// @param duration_ms
function sleep(_duration) {
	if instance_exists(GenCont) exit
	var _t = get_timer() div 1_000
	with (UberCont) _duration *= opt_freeze
    while (get_timer() - _t) < _duration { /* ... */ }
}