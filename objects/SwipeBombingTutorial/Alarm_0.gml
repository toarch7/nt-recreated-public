var xpos = 10016,
	ypos = 10016

/*
// commented out because teaching player to explode themselves is too funny

var count = 10 // min floor count

with Player {
	xpos = x
	ypos = y
}

var step = 48,
	radius = 32

for(var yy = view_yview; yy < view_yview + view_height; yy += step) {
	for(var xx = view_xview; xx < view_xview + view_width; xx += step) {
		var _num = 0
		
		with Floor {
			if point_in_circle(bbox_center_x, bbox_center_y, xx, yy, radius)
				_num ++
		}
		
		if _num > count {
			xpos = xx
			ypos = yy
		}
	}
}*/

x = xpos + 72
y = ypos - 64

xstart = x
ystart = y

image_alpha = 0