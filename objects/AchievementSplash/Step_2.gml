if lockstep_stop
	exit

x = view_xview + view_width / 2
y = view_yview - 4

if instance_exists(GenCont) {
    alarm[0] = 90
    exit
}

if instance_exists(Spiral) exit

if ok {
    if alarm[0] < 10 {
        if index > 0 {
            index = lerp(index, 0, 0.8)

            if !index index = 0
        }
    } else if index < 4 {
        index = lerp(index, 4, 0.8)
    }
} else alarm[0] = 300