if lockstep_stop
	exit

if instance_exists(GenCont) exit

var _player = instance_nearest(x, y, Player)
if !instance_exists(_player) exit

if scrChestOpened() exit
	
if scrUltraCheckPlayerRace(_player, Race.Steroids, UltraSkill.GetLoaded) {
	for(var _ammo_type = Ammo.Bullets; _ammo_type < Ammo.NUM_AMMO_TYPES; _ammo_type ++) {
		scrPlayerGiveAmmo(_player, _ammo_type, scrAmmoGetPickupAmount(_ammo_type) * 2, true)
	}
}
else {
	var _ammo_type = scrAmmoDecideType(_player, true),
		_give_amount = scrAmmoGetPickupAmount(_ammo_type) * 2
	
	scrPlayerGiveAmmo(_player, _ammo_type, _give_amount, true)
}

snd_play(GameCont.underwater ? sndOasisChest : sndAmmoChest)

instance_destroy()