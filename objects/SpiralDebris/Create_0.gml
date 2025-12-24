dist = random(135) + 10
angle = random_angle
turnspeed = orandom(4)
rotspeed = orandom(8)
sound = false

image_index = random(image_number)
image_speed = 0

if instance_exists(GameCont) {
	var _area = GameCont.area
    sprite_index = asset_get_index("sprDebris" + string(_area))

    if random(50) < 1 {
        /**/ if (_area == area_desert) sprite_index = sprBanditHurt
        else if (_area == area_sewers) sprite_index = sprRatHurt
        else if (_area == area_scrapyards) sprite_index = sprCarIdle
        else if (_area == area_caves) sprite_index = sprSpiderHurt
        else if (_area == area_city) sprite_index = sprFrozenCar
        else if (_area == area_labs) sprite_index = sprFreak1Hurt
        else if (_area == area_pizza_sewers) sprite_index = sprSlice

        image_index = 1
        rotspeed = random_range(20, 30) * choose(1, -1)
    }

}

image_xscale = 0
image_yscale = 0
grow = 0

image_angle = random_angle