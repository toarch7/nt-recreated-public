random_set_seed(global.rng_state[RNGStates.Generation])
instance_create(0, 0, TopCont)
wave = 0

with Player {
	x = 10016
	y = 10016
	xprevious = x
	yprevious = y
	xstart = x
	ystart = y
	
	scr_camera_set_position(x, y, fa_center, fa_middle)
}

background_set_colour(scrAreaGetBackroundColor(GameCont.area))

if !is_undefined(global.customareacolors) && !is_undefined(global.customareacolors[$ string(GameCont.area)]) {
    var col = global.customareacolors[$ string(GameCont.area)]

    if !is_undefined(col) && is_array(col) && array_length(col) == 3 {
        background_set_colour(make_color_rgb(col[0], col[1], col[2]))
    }
}

scrTips()

goal = scrAreaGetGenerationGoal()

if (GameCont.area == area_campfire) {
    for (var xx = -2; xx <= 2; xx ++) {
        for (var yy = -1; yy <= 1; yy ++) {
            instance_create(10000 + xx * 32, 10000 + yy * 32, Floor)
        }
    }
	
    repeat (7) {
        with (instance_create(10000, 10000, FloorMaker)) goal = other.goal
    }
}

safespawn = scrAreaHasSafespawn()
safedir = choose(0, 90, 180, 270)

if save_get_value("game", "tutorial", true) {
	instance_create(x, y, TutCont)
	safespawn = true
    goal = 5
}

alarm[5] = 600

with instance_create(10000, 10000, FloorMaker) {
    goal = other.goal
}

with (GameCont) {
	if (!gocrib && scr_skill_get(mut_patience) && !patient) {
	    skillpoints ++
		patiencepick = true
	    patient = true
	}
}

with (MusCont) alarm[11] = 1

scrLetterbox(true, 3)
