if lockstep_stop
	exit

var _player, _give_amount = num;

if !instance_is(other, Player) {
	_player = instance_nearest(x, y, Player)
}
else _player = other.id

with (scr_ultra_get(Race.CoopUltra, 1) ? Player : _player) {
	scrPlayerHeal(id, _give_amount, true)
	instance_create(x, y, HealFX)
}

instance_create(x, y, SmallChestPickup)

snd_play(scr_skill_get(mut_second_stomach) ? sndHPPickupBig : sndHPPickup)

instance_destroy()