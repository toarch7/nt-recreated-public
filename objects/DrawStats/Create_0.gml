
scrInit() // this is not right but not as bad how it was

var secretchars = (UberCont.cgot[13] > 0) + (UberCont.cgot[14] > 0) + (UberCont.cgot[15] > 0),
	_x = secretchars < 3 ? 16 : 10

crowngot = UberCont.crowngot

widescreen = 32

select = 0

with instance_create(_x, view_height - 32, StatChar) {
    num = 0
    image_index = 0
    pos = 0
	
    depth = -150
}

for (var c = 1; c <= (12 + secretchars); c ++) {
	if c == 13 && !UberCont.ctot_runs[13]
		continue
	
    _x += 20
	
    with instance_create(_x, view_height - 32, StatChar) {
        num = c
        
		image_index = c
        pos = c
		
        depth = -150
    }
}

camera_set_pos(0, 0)
