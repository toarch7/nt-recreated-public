if lockstep_stop
	exit

if instance_exists(GenCont) exit

var _player = instance_nearest(x, y, Player)
if !instance_exists(_player) exit

if scrChestOpened() exit

var m = _player.ammo

// Get Loaded
if scr_ultra_get(Race.Steroids, UltraSkill.GetLoaded) {
	var _player_ammo_type = scrAmmoDecideType(_player, true),
		_player_ammo_type_b = scrAmmoDecideType(_player, true)
	
	for(var _ammo_type = Ammo.Bullets; _ammo_type < Ammo.NUM_AMMO_TYPES; _ammo_type ++) {
		if (_player_ammo_type != _ammo_type && _player_ammo_type_b != _ammo_type) {
			var _give_amount = scrAmmoGetPickupAmount(_ammo_type) * 3
			scrPlayerGiveAmmo(_player, _ammo_type, _give_amount, true)
		}
	}
}
else {
	var _ammo_type = scrAmmoDecideTypeMystery(_player),
		_give_amount = scrAmmoGetPickupAmount(_ammo_type) * 3
	
	scrPlayerGiveAmmo(_player, _ammo_type, _give_amount, true)
}

snd_play(GameCont.underwater ? sndOasisChest : sndAmmoChest)

instance_destroy()