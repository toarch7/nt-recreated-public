friction = 0.2

blink = 30
alarm[0] = 200+random(30)


//RUSH CROWN
if instance_exists(Player){if GameCont.crown = 4 alarm[0] /= 3}

image_speed = 0

if instance_exists(Player) && Player.curse && Player.bcurse && !irandom(3) {
    instance_change(CursedPickup, 1)
}

