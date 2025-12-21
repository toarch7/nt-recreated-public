/// @description Cry more
alarm[1] = irandom_range(120, 360)

if (snd_is_playing(sndCuzCryNew)) exit

var _sound;

do {
	_sound = asset_get_index("sndCuzCryBonus" + string(irandom_range(1, 10)))
}
until (_sound != lastsnd)

lastsnd = _sound
snd_play(_sound)