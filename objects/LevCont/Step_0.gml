view_xview = 0
view_yview = 0

// align
var objects = [ SkillIcon, CrownIcon ]

for(var i = 0; i < array_length(objects); i ++) {
	var obj = objects[i],
		step = 32, xx, a = false
	
	if !instance_exists(obj)
		continue
	
	do {
		xx = view_width / 2 + (step * max(0, instance_number(obj) - 1) * 0.5)
		
		if a
			step -= 2
		
		a = true
	}
	until xx < view_width
	
	xx = view_xview + xx
	
	with obj {
		x = xx
		xx -= step
	}
}
