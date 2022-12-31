dist = random(135) + 10
angle = random(360)
turnspeed = random(8) - 4
rotspeed = random(16) - 8

image_index = random(image_number)
image_speed = 0
if instance_exists(GameCont) {
    sprite_index = asset_get_index("sprDebris" + string(GameCont.area))

    if random(50) < 1 {

        if GameCont.area = 1 sprite_index = sprBanditHurt

        if GameCont.area = 2 sprite_index = sprRatHurt

        if GameCont.area = 3 sprite_index = sprCarIdle

        if GameCont.area = 4 sprite_index = sprSpiderHurt

        if GameCont.area = 5 sprite_index = sprFrozenCar

        if GameCont.area = 6 sprite_index = sprFreak1Hurt

        if GameCont.area = 102 sprite_index = sprSlice

        image_index = 1
        rotspeed = (10 + random(20)) * choose(1, - 1)
    }

}

image_xscale = 0
image_yscale = 0
grow = 0

image_angle = random(360)