snd_stop(sndPortalLoop)

var _sounds = array_union(
	scr_sound_pack("PortalLightning", 8),
	scr_sound_pack("PortalFlyby", 4))

array_foreach(_sounds, function(_sound) {
	audio_stop_sound(_sound)
})