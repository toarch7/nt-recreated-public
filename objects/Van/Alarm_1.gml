drive = 0

if freak {
	instance_destroy(); exit
}


snd_play_hit_big(sndVanOpen, 0.1)
drawspr = sprVanDeactivate
drawimg = 0

alarm[2] = 15

repeat 3 + GameCont.loops
	instance_create(x - (55 * right), y + orandom(5), Grunt)

var spwn;

if irandom(1) {
	spwn = choose(Inspector, Shielder)
	
	repeat 1 + GameCont.loops {
		instance_create(x - 50 * right, y + orandom(5), spwn)
	}
}
else {
	spwn = choose(EliteGrunt, EliteInspector, EliteShielder)
	
	repeat GameCont.loops {
		instance_create(x - 50 * right, y + orandom(5), spwn)
	}
}