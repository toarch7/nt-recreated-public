if lockstep_stop
	exit

if instance_exists(GenCont) exit
if scrChestOpened() exit

var _shift = curse ? 736817 : 0

if (_shift != 0) global.rng_state[RNGStates.WeaponDrops] += _shift
	
var _extra = 1 + curse * 2,
	_player = instance_nearest(x, y, Player),
	_wep = scrDecideWep(_extra, curse),
	_count = 1

if scr_ultra_get(Race.Steroids, UltraSkill.Ambidextrous) {
	_count ++
}

repeat (_count) scrWeaponPickupCreate(x + orandom(2), y + orandom(2), _wep, true)

if GameCont.underwater {
	snd_play(sndOasisChest)
}
else if curse {
	snd_play(sndCursedChest)
}
else {
	snd_play(sndWeaponChest)
}

if (_shift != 0) global.rng_state[RNGStates.WeaponDrops] -= _shift

instance_destroy()
