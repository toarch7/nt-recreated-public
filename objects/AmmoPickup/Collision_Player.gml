if lockstep_stop
	exit

var _player;

if !instance_is(other, Player) {
	_player = instance_nearest(x, y, Player)
}
else _player = other.id

with (scrUltraCheck(Race.CoopUltra, 1) ? Player : _player) {
	var _ammo_type = scrAmmoDecideType(id, false),
		_give_amount = typ_ammo[_ammo_type]
	
	//RUSH CROWN
	if scrCrownCheck(Crwn.Haste) {
		_give_amount ++
	}
	
	scrPlayerGiveAmmo(id, _ammo_type, _give_amount, true)
}

instance_create(x, y, SmallChestPickup)

snd_play(sndAmmoPickup)

instance_destroy()