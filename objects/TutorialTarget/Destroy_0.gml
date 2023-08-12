
speed = 0

event_inherited()

repeat 5 + irandom(3) {
	with instance_create(x, y, Feather) {
		sprite_index = sprTutorialSplinter
		image_index = irandom(sprite_get_number(sprite_index) - 1)
	}
}
