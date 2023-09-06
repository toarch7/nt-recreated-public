gameovertime = 0

text = loc("YOU DID NOT REACH THE NUCLEAR THRONE")

if GameCont.area == 7 && GameCont.subarea == 3 text = loc("YOU ALMOST REACHED THE NUCLEAR THRONE") if GameCont.loops text = loc("THE STRUGGLE CONTINUES")

if GameCont.win {
    if instance_exists(Cinematic) {
        text = loc("YOU HAVE REACHED THE NUCLEAR THRONE")
    } else if GameCont.area == 106 && GameCont.subarea == 3 {
        text = loc("THE STRUGGLE IS OVER")
    }
}

var p = 0

repeat 2 {
    with instance_create(view_xview + view_width / 2, view_yview + view_height / 2 + 58 + p * 32, PauseButton) {
        image_index = p
    }

    p ++
}

if UberCont.daily_run && !UberCont.weekly_run {
    with instance_find(PauseButton, 0) {
        sprite_index = sprGameOverResults
    }

    with instance_find(PauseButton, 1) {
        image_index = 0
    }
}

kills = GameCont.kills

death_pos = 0

offsety = 128

image_speed = 0.4

if instance_exists(Credits) {
    depth = -102
}

with MobileUI
	instance_destroy()

file_delete("gamestate.dat")