if !instance_exists(Player) && UberCont.daily_run {
    if UberCont.weekly_run {
        daily_time = scrTime(scrReal(UberCont.weekly_data[? "time"]))
        if !is_undefined(UberCont.weekly_data[? "time"]) {
            UberCont.weekly_data[? "time"]--
        }
    } else daily_time = scrTime(UberCont.daily_time)
}

alarm[0] = 30

crosshair = save_get_val("visual", "crosshair", 0)