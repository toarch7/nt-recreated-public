snd_play(sndPlasmaHit)

event_inherited()

with instance_create(x, y, PlasmaImpact) {
    team = other.team
    hitid = other.hitid
    sprite_index = sprPopoPlasmaImpact
}