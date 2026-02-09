event_inherited()
snd_play_hit(sndPlasmaHit, 0.2)
with (scr_damage_create(x, y, PlasmaImpact)) {
	if (other.sprite_index == sprPopoPlasma) {
		sprite_index = sprPopoPlasmaImpact
	}
}
sleep(10)