if lockstep_stop
	exit

if instance_exists(GenCont) exit
if scrChestOpened() exit

var _player = instance_nearest(x, y, Player),
	_count = 3

if scr_ultra_get(Race.Steroids, UltraSkill.Ambidextrous) {
	_count ++
}

random_set_seed(dropseed)

instance_create(x, y, PortalClear)

repeat _count {
	var _wep = scrDecideWep(1 + other.curse * 2, false),
		_x = bbox_center_x + orandom(2),
		_y = bbox_center_y + orandom(2)
		
	with scrWeaponPickupCreate(_x, _y, _wep, true) {
		curse = other.curse
	}
}

snd_play_hit(sndBigCursedChest)

with (_player) snd_play_hit_big(snd_chst)

GameCont.nochest = 0

instance_destroy()