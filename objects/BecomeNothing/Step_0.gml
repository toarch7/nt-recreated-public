if (hp <= 0) hp = max_hp

speed = 0
x = xstart
y = ystart

if (sprite_index == sprNothingActivate) with (BackCont) shake = 5 - other.drawimg

drawimg += image_speed

if drawimg >= sprite_get_number(sprite_index) {
	drawimg = 0
	
	if sprite_index == sprNothingActivate {
	    instance_create(x, y, Nothing)
	    scrBossIntro(3)
		
	    instance_destroy()
	}
	else {
	    image_speed = 0
	    drawimg = 4
	}
}