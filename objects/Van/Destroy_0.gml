speed /= 20
event_inherited()
snd_play_hit_big(sndIDPDNadeExplo, 0.1)
scrDrop(100, 0)
scrDrop(100, 0)
scrDrop(100, 0)
repeat(3) {
    with(instance_create(((x + random(40)) - 20), ((y + random(20)) - 10), PopoExplosion)) {
        team = other.team
        hit_id = other.hit_id
    }
}
repeat(7)
instance_create(((x + random(96)) - 48), ((y + random(48)) - 24), BlueFlame)
if (freak == 1) {
    repeat(3)
    instance_create(((x + random(16)) - 8), ((y + random(16)) - 8), PopoFreak)
}

with WantVan
canspawn = 1