friction = 0.2

blink = 30
alarm[0] = ceil((200 + random(30)) / ((5 + GameCont.loops) / 5) * scrCustomModePickupTimeMult())

//RUSH CROWN
if scrCrownCheck(crwn_haste) {
	alarm[0] /= 3
}

image_speed = 0

if instance_exists(Player) {
	var _curse = scrPlayerCountCursed(all)
	
	if _curse >= 2 && random(2) < 1 {
		instance_create(x, y, CursedPickup)
		instance_destroy(id, false)
	}
}