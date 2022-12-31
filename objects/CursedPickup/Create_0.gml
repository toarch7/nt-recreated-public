friction = 0.2

blink = 30
alarm[0] = 200 + random(30)


//RUSH CROWN
if instance_exists(Player) {
    if GameCont.crown = 4 alarm[0] /= 3
}
snd_play_hit(sndCursedPickup, 0.2)
image_speed = 0