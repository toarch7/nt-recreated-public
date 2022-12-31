random_set_seed(global.rng_state[0])

instance_create(0, 0, TopCont)
wave = 0

if instance_exists(Player) {

    with Player {
        x = 10016
        y = 10016
    }

    if GameCont.area = 0 __background_set_colour(make_color_rgb(106, 122, 175)) if GameCont.area = 1 __background_set_colour(make_color_rgb(175, 143, 106)) if GameCont.area = 2 __background_set_colour(make_color_rgb(76, 89, 70)) if GameCont.area = 3 __background_set_colour(make_color_rgb(138, 150, 158)) if GameCont.area = 4 __background_set_colour(make_color_rgb(129, 82, 188)) if GameCont.area = 5 __background_set_colour(make_color_rgb(180, 189, 197)) if GameCont.area = 6 __background_set_colour(make_color_rgb(9, 28, 32)) if GameCont.area = 7 __background_set_colour(make_color_rgb(97, 29, 36)) if GameCont.area = 100 __background_set_colour(make_color_rgb(67, 53, 35)) if GameCont.area = 101 __background_set_colour(make_color_rgb(81, 209, 200)) if GameCont.area = 102 __background_set_colour(make_color_rgb(160, 75, 99)) if GameCont.area = 103 or GameCont.area = 107 __background_set_colour(make_color_rgb(238, 240, 242)) if GameCont.area = 104 __background_set_colour(make_color_rgb(255, 156, 35)) if GameCont.area = 105 __background_set_colour(make_color_rgb(42, 144, 12)) if GameCont.area = 106 __background_set_colour(make_color_rgb(245, 250, 251))

} else __background_set_colour(make_color_rgb(106, 122, 175))

if !is_undefined(global.customareacolors) && !is_undefined(global.customareacolors[$ string(GameCont.area)]) {
    var col = global.customareacolors[$ string(GameCont.area)]

    if !is_undefined(col) && is_array(col) && array_length(col) == 3 {
        __background_set_colour(make_color_rgb(col[0], col[1], col[2]))
    }
}

//test 4
//background_color = make_color_rgb(93,77,168)

scrTips()

goal = 110

if GameCont.area = 100 goal = 40

if GameCont.area == 103 or GameCont.area == 101 or GameCont.area == 7 goal = 130

if GameCont.area == 102 or GameCont.area == 0 goal = 70

if GameCont.area == 106 && GameCont.area == 3 goal = 48

if GameCont.area == 7 && GameCont.subarea == 3 goal = 420

if GameCont.area == 107 goal = 20

if GameCont.area == 0 {
    goal = 60

    for (var xx = -2; xx <= 2; xx++) {
        for (var yy = -1; yy <= 1; yy++) {
            instance_create(10000 + xx * 32, 10000 + yy * 32, Floor)
        }
    }

    repeat 7 {
        with instance_create(10000, 10000, FloorMaker) {
            goal = other.goal
        }
    }
}

if save_get_val("game", "tutorial", 1) {
    goal = 5
}

if instance_exists(MenuGen) goal = 110

crown = save_get_val("ccrown", string(GameCont.crown), 1)
splat = 0

alarm[5] = 600

with instance_create(10000, 10000, FloorMaker) {
    goal = other.goal
}

textgenerating = loc("GENERATING...") + " "
if GameCont.race == 6 && GameCont.level >= 10 {
    textgenerating = loc("VERIFYING...") + " "
}

safespawn = 0
safedir = irandom(3) * 90
safefloors = 0

if GameCont.loops {
    safespawn = 1
}

if GameCont.area == 0 or GameCont.area == 107 or GameCont.area == 100 or(GameCont.area == 7 && GameCont.subarea == 3) or(GameCont.area == 106 && GameCont.subarea == 3) {
    safespawn = 0
}

if skill_get(25) && !GameCont.patient {
    GameCont.skillpoints++GameCont.patiencepick = 1
    GameCont.patient = 1
}