drive = false

if (freak) {
	instance_destroy()
	exit
}


snd_play_hit_big(sndVanOpen, 0.1)
drawspr = sprVanDeactivate
drawimg = 0

alarm[2] = 15

repeat (3 + GameCont.loops) {
	instance_create(x - (55 * right), y + orandom(5), Grunt)
}

var _spawn;

if (random(1) < 0.5) {
	_spawn = choose(Inspector, Shielder)
	
	repeat (1 + GameCont.loops) {
		instance_create(x - 50 * right, y + orandom(5), _spawn)
	}
}
else {
	_spawn = choose(EliteGrunt, EliteInspector, EliteShielder)
	
	repeat (GameCont.loops) {
		instance_create(x - 50 * right, y + orandom(5), _spawn)
	}
}