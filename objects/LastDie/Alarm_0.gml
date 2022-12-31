with(instance_create(x, y, PopoExplosion)) {
    team = other.team
    hit_id = other.hit_id
}
repeat(4)
instance_create(((x + random(48)) - 24), ((y + random(48)) - 24), BlueFlame)