
event_inherited()

num = 4

if scr_skill_get(mut_second_stomach) {
	num = 8
}

spr_dead = sprHealthChestOpen

if (GameCont.area == area_pizza_sewers) {
	sprite_index = choose(sprPizzaChest1, sprPizzaChest2)
	spr_dead = sprPizzaChestOpen
}
