if lockstep_stop
	exit

if (meleedamage && scr_can_hit(other.id)) {
	scr_hit(other.id, floor(meleedamage * 0.1), hitid)
	snd_play_hit(snd_mele)
}