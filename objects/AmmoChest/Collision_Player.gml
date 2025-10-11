if lockstep_stop
	exit

if instance_exists(GenCont) exit

var _player = instance_nearest(x, y, Player)
if !instance_exists(_player) exit

if scrChestOpened() exit
	
// Get Loaded
if _player.race == Race.Steroids && scrUltraCheck(_player.race, 2) {
	for(var _ammo_type = Ammo.Bullets; _ammo_type < Ammo.NUM_AMMO_TYPES; _ammo_type ++) {
		scrPlayerGiveAmmo(_player, _ammo_type, typ_ammo[_ammo_type], true)
	}
}
else {
	var _ammo_type = scrAmmoDecideType(_player, true),
		_give_amount = typ_ammo[_ammo_type] * 2
	
	scrPlayerGiveAmmo(_player, _ammo_type, _give_amount, true)
}

snd_play(GameCont.underwater ? sndOasisChest : sndAmmoChest)

instance_destroy()