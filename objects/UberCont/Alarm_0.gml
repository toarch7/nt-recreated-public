alarm[0] = 30

//time stats
tot_time++

if instance_exists(Player) {
    with Player {
        if is_me {
            UberCont.ctot_time[race]++
            break
        }
    }
}

if daily_time {
    daily_time--
}