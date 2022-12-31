if sprite_index = sprBigMaggotAppear {
    instance_change(BigMaggot, 0)
    alarm[1] = 10 + random(10)
} else if sprite_index = sprBigMaggotBurrow {
    visible = 0
}