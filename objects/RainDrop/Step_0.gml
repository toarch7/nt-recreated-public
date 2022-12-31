addx -= 12
addy -= 12

if addx <= 0 {
    instance_destroy()
    if position_meeting(x, y, Floor) instance_create(x, y, RainSplash)
    else instance_create(x, y - 8, RainSplash)
}