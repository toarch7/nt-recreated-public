event_inherited()

snd_play_hit_big(sndDevastatorExplo, 0.3)
instance_create(x, y, PortalClear)

repeat (4) {
	instance_create(x + orandom(24), y + orandom(24), PlasmaImpact)
}