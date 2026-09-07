speed /= 20
event_inherited()
snd_play_hit_big(sndIDPDNadeExplo, 0.1)

repeat (3) scrDrop(100, 0)

repeat (3) {
    scr_damage_create(x + orandom(10), y + orandom(10), PopoExplosion)
}

repeat (7) {
	instance_create(x + orandom(48), y + orandom(48), BlueFlame)
}

if (freak) {
    repeat(3) {
	    instance_create(x + orandom(8), y + orandom(8), PopoFreak)
	}
}

with (WantVan) canspawn = true