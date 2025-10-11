if lockstep_stop
	exit

if instance_exists(GenCont) exit

var _player = instance_nearest(x, y, Player)
if !instance_exists(_player) exit

if scrChestOpened() exit

var m = _player.ammo

// Get Loaded
if _player.race == Race.Steroids && scrUltraCheck(_player.race, 2) {
	event_perform_object(AmmoChest, event_type, event_number)
	exit
}

var _ammo_type = scrAmmoDecideTypeMystery(_player),
	_give_amount = typ_ammo[_ammo_type] * 3

scrPlayerGiveAmmo(_player, _ammo_type, _give_amount, true)

snd_play(GameCont.underwater ? sndOasisChest : sndAmmoChest)

instance_destroy()