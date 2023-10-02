with MusCont {
    event_perform(ev_alarm, 0)
    alarm[0] = -1
}

dix = 32
diy = 32

__background_set_colour(make_color_rgb(106, 122, 175))

if !is_undefined(global.customareacolors) && !is_undefined(global.customareacolors[$ "0"]) {
    var col = global.customareacolors[$ "0"]

    if !is_undefined(col) && is_array(col) && array_length(col) == 3 {
        __background_set_colour(make_color_rgb(col[0], col[1], col[2]))
    }
}

repeat 3 {
    repeat 4 {
        mody = choose(32, 0, - 32)

        instance_create(x + dix + mody, y + diy + mody, Floor)
        instance_create(x + dix + mody + 32, y + diy + mody, Floor)
        instance_create(x + dix + mody - 32, y + diy + mody, Floor)

        instance_create(x + dix + mody, y + diy + mody + 32, Floor)
        instance_create(x + dix + mody + 32, y + diy + mody + 32, Floor)
        instance_create(x + dix + mody - 32, y + diy + mody + 32, Floor)

        instance_create(x + dix + mody, y + diy + mody - 32, Floor)
        instance_create(x + dix + mody + 32, y + diy + mody - 32, Floor)
        instance_create(x + dix + mody - 32, y + diy + mody - 32, Floor)

        dix += 32
    }

    dix = 0
    diy += 32
}

//view_xview = 64 - view_width / 2
//view_yview = 48 - view_height / 2

repeat 4 {
    instance_create(choose(0, 32, 64, 96, 128), choose(0, 32, 64, 96, 128), FloorMaker)
}

alarm[1] = 2

instance_create(0, 0, BackCont)
instance_create(0, 0, TopCont)

instance_create(0, 0, Menu)