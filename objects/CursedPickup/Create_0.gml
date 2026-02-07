friction = 0.2

blink = 30
alarm[0] = ceil((200 + random(30)) * scrCustomModePickupTimeMult())

if (scrCrownCheck(crwn_haste)) alarm[0] /= 3

snd_play_hit(sndCursedPickup, 0.2)
image_speed = 0