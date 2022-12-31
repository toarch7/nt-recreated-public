snd_play(sndPlasmaHit)
event_inherited()

with instance_create(x, y, PlasmaImpact) {
    team = other.team
    hit_id = other.hit_id
    sprite_index = sprPopoPlasmaImpact
}