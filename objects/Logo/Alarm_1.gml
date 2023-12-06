alarm[0] = -1

var ypos = round(2 * 24)
var _i = 0

for (var i = 0; i <= 4; i++) {
    _i ++

    with instance_create(view_xview + view_width / 2, view_yview + view_height / 2 - ypos + i * 24, MainMenuButton) {
        image_index = i
		
		if i == 1 && !MultiplayerConfig
			available = 0
    }
}

snd_stop(sndLogoLoop)

instance_create(0, 0, ButtonDiscord)
instance_create(0, 0, DiscordAuth)
instance_create(0, 0, ButtonAchievements)

instance_destroy()