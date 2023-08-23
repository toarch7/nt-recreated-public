if GameCont.area == 107 && !instance_exists(CarVenusFixed) {
    with Scorchmark {
        with instance_create(x, y, CarVenusFixed)
			sprite_index = sprVenusCarFixed
		
		instance_destroy()
    }
}

alarm[1] = 300