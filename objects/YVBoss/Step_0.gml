event_inherited()

if (ammo) {
	walk = 0
}
else if (walk > 0) {
	motion_add(direction, 0.5)
	walk --
}

right = (gunangle >= 90 && gunangle < 270) ? -1 : 1

if (!sndhalfhp && hp <= max_hp * 0.5) {
	snd_play(sndGunGodLowHP)
	sndhalfhp = true
}

if (!instance_exists(Player) && !sndtaunt) {
	tauntdelay ++
	
	if (tauntdelay >= 50) {
		snd_play(sndGunGodTaunt)
		sndtaunt = true
		ammo = 0
	}
}
else tauntdelay = 0

if (speed > 4) speed = 4
