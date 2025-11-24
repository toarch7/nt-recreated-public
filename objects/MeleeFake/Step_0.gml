if lockstep_stop
	exit


scrTarget()

var _wakeup_call;

if hp < max_hp || !instance_number(enemy) || (instance_exists(target) && scrTargetIsVisible(target, 64, true) && !instance_exists(Portal)) {
	_wakeup_call = true
}
else _wakeup_call = false

if _wakeup_call {
	var _object = self.__get_spawn_enemy_object()
	snd_play(sndAssassinGetUp)
	instance_create(x, y, _object)
	instance_destroy(id, false)
	exit
}

scrFirstFrameAnim(0.4)
